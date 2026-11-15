"""Retoca cara a cara una escena del belén para que cada rostro se parezca a su figura de referencia.

Recorta cada cara (posición fijada por el reparto, no por reconocimiento facial), pide al modelo que
redibuje solo ese rostro con la referencia de esa persona y lo vuelve a pegar con borde difuminado.
Uso: python retocar-caras.py <escena> <salida> <figuritas|realistas> <modelo> [id ...]
Requiere Pillow y OPENROUTER_API_KEY.
"""
import base64, io, json, os, sys, urllib.request
from PIL import Image, ImageDraw, ImageFilter

# Centro de cada cara y lado del recorte, normalizados (escenas 18-personas, 1672 × 941).
CARAS = {
    "alfredo": (165, 262, 150), "luis": (330, 262, 150), "santi": (455, 265, 150),
    "yanira": (757, 92, 150), "luz": (940, 95, 150),
    "ivonne": (787, 408, 150), "cristian": (900, 378, 160),
    "berta": (190, 505, 180), "fran": (397, 497, 160), "leo": (600, 428, 150),
    "francis": (695, 640, 160), "roser": (1078, 420, 150), "celeste": (1195, 445, 160),
    "humberto": (1308, 290, 160), "ernesto": (1515, 258, 160), "carlos": (1462, 445, 150),
    "elisa": (1345, 553, 160), "rosy": (1585, 588, 170),
}
NOMBRES = {"alfredo": "Alfredo", "luis": "Luis", "santi": "Santi", "yanira": "Yanira", "luz": "Luz", "ivonne": "Ivonne",
           "cristian": "Cristian", "berta": "Berta", "fran": "Fran", "leo": "Leo", "francis": "Francis", "roser": "Roser",
           "celeste": "Celeste", "humberto": "Humberto", "ernesto": "Ernesto", "carlos": "Carlos", "elisa": "Elisa", "rosy": "Rosy"}
RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def data_url(img):
    buf = io.BytesIO(); img.convert("RGB").save(buf, "JPEG", quality=92)
    return "data:image/jpeg;base64," + base64.b64encode(buf.getvalue()).decode()


def busto(pid, estilo):
    carpeta = "output/figuras" if estilo == "figuritas" else "output/figuras/realistas"
    im = Image.open(os.path.join(RAIZ, carpeta, pid + ".png")).convert("RGBA")
    x0, y0, x1, y1 = im.getchannel("A").getbbox()
    im = im.crop((x0, y0, x1, y0 + int((y1 - y0) * 0.36)))
    fondo = Image.new("RGBA", im.size, (235, 235, 235, 255)); fondo.alpha_composite(im)
    return fondo


def pedir(modelo, recorte, ref, pid, estilo, foto=None):
    aspecto = ("a hand-carved painted terracotta nativity figurine face" if estilo == "figuritas"
               else "a realistic human face in a photograph")
    prompt = (f"Image 1 is a crop of a nativity scene showing {NOMBRES[pid]}. Image 2 is the reference of {NOMBRES[pid]}. "
              f"Redraw ONLY the face and hair in image 1 so it clearly resembles the reference: face shape, eyes, nose, mouth, "
              f"smile, age, hairstyle, hair colour, glasses only if the reference has them, beard only if the reference has it. "
              f"Keep {aspecto}. Keep exactly the same framing, head position, size, angle, crown or hood, costume, hands, props, "
              f"lighting and colours of image 1. The output must be the same close-up as image 1: the head keeps exactly the same size and "
              f"position in the frame; do not zoom out, do not show the whole body, do not add crowns, halos or objects. No text.")
    prompt += " " + os.environ.get("EXTRA", "")  # notas concretas de esa persona
    imagenes = [recorte, ref] + ([foto] if foto else [])
    if foto:
        prompt += (f" Image 3 is a real photograph of {NOMBRES[pid]}: it is the main likeness reference; match the face to it "
                   f"(eyes, nose, mouth, face width, wrinkles, hair, glasses or beard) while keeping the style of image 1.")
    body = {"model": modelo, "modalities": ["image", "text"],
            "messages": [{"role": "user", "content": [{"type": "text", "text": prompt},
                                                     *[{"type": "image_url", "image_url": {"url": data_url(i)}} for i in imagenes]]}]}
    req = urllib.request.Request("https://openrouter.ai/api/v1/chat/completions", json.dumps(body).encode(),
                                 {"Authorization": "Bearer " + os.environ["OPENROUTER_API_KEY"], "Content-Type": "application/json"})
    r = json.load(urllib.request.urlopen(req, timeout=300))
    url = r["choices"][0]["message"]["images"][0]["image_url"]["url"]
    return Image.open(io.BytesIO(base64.b64decode(url.split(",", 1)[1]))), r.get("usage", {}).get("cost")


def main():
    escena, salida, estilo, modelo, *ids = sys.argv[1:]
    im = Image.open(escena).convert("RGB"); k = im.width / 1672
    origen = Image.open(os.environ["ORIGEN"]).convert("RGB") if os.environ.get("ORIGEN") else im  # recortar del original al repetir
    total = 0
    for pid in ids or CARAS:
        cx, cy, lado = (v * k for v in CARAS[pid])
        caja = tuple(int(v) for v in (cx - lado / 2, cy - lado / 2, cx + lado / 2, cy + lado / 2))
        recorte = origen.crop(caja)
        foto = os.path.join(os.environ.get("FOTOS", ""), pid + ".jpg")  # foto real recortada (opcional)
        foto = Image.open(foto) if os.environ.get("FOTOS") and os.path.exists(foto) else None
        nuevo, coste = pedir(modelo, recorte.resize((1024, 1024), Image.LANCZOS), busto(pid, estilo), pid, estilo, foto)
        total += coste or 0
        nuevo = nuevo.convert("RGB").resize(recorte.size, Image.LANCZOS)
        mascara = Image.new("L", recorte.size, 0); m = recorte.width
        ImageDraw.Draw(mascara).ellipse((m * 0.14, m * 0.08, m * 0.86, m * 0.9), fill=255)
        im.paste(nuevo, caja[:2], mascara.filter(ImageFilter.GaussianBlur(m * 0.06)))
        print(pid, "ok", coste, flush=True)
    im.save(salida)
    print("coste total", round(total, 3))


if __name__ == "__main__":
    main()
