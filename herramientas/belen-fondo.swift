// Monta el belén 16:9 sobre un fondo vacío colocando por capas las figuras aprobadas (sin regenerar caras).
// Uso: swift herramientas/belen-fondo.swift <fondo.png> <salida.png> [figuritas|realista] [rotulo]
// Posiciones en unidades de una vista de 1400 px de ancho; (x = centro, y = base desde arriba, h = alto visible).
import AppKit

let a = CommandLine.arguments
let realista = a.count > 3 && a[3] == "realista"
let rotulo = a.contains("rotulo")
let W = 3840, H = 2160, k = CGFloat(W) / 1400

// Orden = de atrás hacia delante.
let figuritas: [(String, CGFloat, CGFloat, CGFloat)] = [
    ("luz", 790, 330, 205), ("yanira", 1085, 350, 205),
    ("rosy", 330, 640, 225), ("leo", 435, 640, 225), ("roser", 540, 640, 225), ("carlos", 645, 640, 225),
    ("humberto", 1095, 640, 225), ("celeste", 1220, 640, 225), ("berta", 1340, 640, 225),
    ("ivonne", 750, 615, 250), ("nino", 880, 605, 90), ("cristian", 990, 615, 255),
    ("alfredo", 105, 775, 300), ("luis", 235, 775, 295), ("santi", 365, 775, 290),
    ("elisa", 515, 770, 280), ("francis", 680, 772, 280),
    ("fran", 1160, 772, 285), ("ernesto", 1285, 775, 295),
]
// Las realistas tienen otro vestuario: Celeste y Yanira son los ángeles; Alfredo y Santi llevan corona.
let realistas: [(String, CGFloat, CGFloat, CGFloat)] = [
    ("celeste", 590, 560, 190), ("yanira", 1150, 560, 200),
    ("ivonne", 770, 590, 205), ("nino", 865, 585, 62), ("cristian", 960, 592, 212),
    ("luz", 290, 640, 230), ("leo", 400, 640, 230), ("roser", 510, 640, 230),
    ("humberto", 1050, 645, 232), ("carlos", 1190, 645, 232), ("ernesto", 1300, 645, 232),
    ("alfredo", 100, 778, 305), ("santi", 230, 778, 305), ("luis", 360, 778, 300),
    ("berta", 510, 775, 298), ("rosy", 650, 775, 290),
    ("elisa", 1040, 775, 298), ("fran", 1170, 778, 300), ("francis", 1300, 778, 302),
]
let layout = realista ? realistas : figuritas
precondition(Set(layout.map { $0.0 }).count == 19)

func trimmed(_ path: String) -> CGImage {
    guard let ns = NSImage(contentsOfFile: path) else { fatalError("Falta \(path)") }
    let src = ns.cgImage(forProposedRect: nil, context: nil, hints: nil)!
    let w = src.width, h = src.height
    let ctx = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: w * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    ctx.draw(src, in: CGRect(x: 0, y: 0, width: w, height: h))
    let p = ctx.data!.bindMemory(to: UInt8.self, capacity: w * h * 4)
    var x0 = w, x1 = 0, y0 = h, y1 = 0
    for y in 0..<h { for x in 0..<w where p[(y * w + x) * 4 + 3] > 16 { x0 = min(x0, x); x1 = max(x1, x); y0 = min(y0, y); y1 = max(y1, y) } }
    return src.cropping(to: CGRect(x: x0, y: y0, width: x1 - x0 + 1, height: y1 - y0 + 1))!
}

let ctx = CGContext(data: nil, width: W, height: H, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
ctx.interpolationQuality = .high
ctx.draw(NSImage(contentsOfFile: a[1])!.cgImage(forProposedRect: nil, context: nil, hints: nil)!, in: CGRect(x: 0, y: 0, width: W, height: H))
for (id, x, y, h) in layout {
    let dir = realista && id != "nino" ? "output/figuras/realistas" : "output/figuras"
    let img = trimmed("\(dir)/\(id).png")
    let hh = h * k, ww = hh * CGFloat(img.width) / CGFloat(img.height)
    let base = CGFloat(H) - y * k
    // Sombra de contacto bajo los pies o la peana.
    ctx.saveGState(); ctx.setFillColor(NSColor(white: 0, alpha: 0.35).cgColor)
    ctx.setShadow(offset: .zero, blur: 6 * k, color: NSColor(white: 0, alpha: 0.6).cgColor)
    ctx.fillEllipse(in: CGRect(x: x * k - ww * 0.42, y: base - ww * 0.05, width: ww * 0.84, height: ww * 0.12)); ctx.restoreGState()
    let r = CGRect(x: x * k - ww / 2, y: base, width: ww, height: hh)
    ctx.draw(img, in: r)
    // Igualar la luz nocturna: oscurecer la figura con su propia silueta como máscara.
    ctx.saveGState(); ctx.clip(to: r, mask: img)
    ctx.setFillColor(NSColor(calibratedRed: 0.02, green: 0.04, blue: 0.12, alpha: realista ? 0.38 : 0.12).cgColor); ctx.fill(r)
    ctx.restoreGState()
}
if rotulo {
    NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
    let shadow = NSShadow(); shadow.shadowBlurRadius = 18; shadow.shadowColor = NSColor(white: 0, alpha: 0.7)
    func line(_ s: String, _ font: String, _ size: CGFloat, _ y: CGFloat) {
        let str = NSAttributedString(string: s, attributes: [.font: NSFont(name: font, size: size)!, .foregroundColor: NSColor.white, .shadow: shadow])
        str.draw(at: NSPoint(x: 1240 - str.size().width / 2, y: y))
    }
    line("ATE les desea Feliz Navidad", "Times-Italic", 128, 1930)
    line("Un belén, muchas historias", "Times-Roman", 52, 1850)
}
try! NSBitmapImageRep(cgImage: ctx.makeImage()!).representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: a[2]))
