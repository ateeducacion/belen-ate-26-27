# Belén de ATE · Navidad 2026–2027

Una felicitación navideña con los compañeros de ATE: **«ATE les desea Feliz Navidad»**.

## Ver la web

Desde esta carpeta:

```sh
python3 -m http.server 8000 --directory web
```

Abre http://localhost:8000. También puedes abrir `web/index.html` directamente. No necesita instalación ni compilación.

## Qué hay preparado

- Web de recorrido visual (scrollytelling) para móvil y escritorio: portada con zoom al portal, cinco capítulos con carrusel anclado (`chapters` en `web/content.js`), travelling por el belén completo y búsqueda de láminas por nombre. `web/story.js` monta los capítulos; el movimiento es CSS (`--p` en `styles.css`) con alternativa en JS para navegadores sin scroll-driven animations (se puede forzar con `?js`).
- La página usa copias WebP ligeras (`web/assets/figuras/web/` y `*.webp`); los PNG originales quedan para ampliar y descargar. Al cambiar una figura, regenera su copia: `cwebp -q 82 -alpha_q 90 -resize 0 960 figura.png -o figuras/web/figura.webp`.
- Las 17 fichas del reparto, preparadas para ampliar su ilustración y descargar su lámina.
- Acceso al belén completo y al PDF resumen de dos páginas cuando se incorporen.
- Instrucciones completas para continuar en [AGENTS.md](AGENTS.md).

Las ilustraciones individuales y los PDF están generados como **borradores locales en `output/`, pendientes de corregir las poses frontales y revisar**. Todavía no están incorporados a la web. Consulta [el estado de continuación](ESTADO-PARA-CONTINUAR.md). La web lo indica y no muestra descargas ficticias. El portal de la portada es una ilustración de ambientación generada con la herramienta integrada de imágenes; no representa el resultado final del equipo.

## Incorporar las ilustraciones

Guarda únicamente los archivos finales que deban verse en la web dentro de `web/assets/`. Edita `web/content.js`:

```js
scene: 'assets/belen-completo.jpg',
collection: 'assets/coleccion-dos-paginas.pdf',
// En la ficha de cada persona:
image: 'assets/ivonne.png',
sheet: 'assets/ivonne-a4.pdf',
```

Las rutas son relativas a `web/`. Sustituye los valores `null` cuando los archivos existan; los controles se activan al recargar. Mantén los identificadores de las 17 personas y reutiliza la misma ilustración en la lámina, la escena y el vídeo para conservar el parecido.

Entregables acordados: 17 láminas A4 verticales, PDF conjunto de exactamente dos páginas, belén panorámico 16:9 y figuras PNG transparentes con fondo separado para montar un vídeo 16:9. Guarda los originales de producción en `output/` y copia al sitio solo los resultados necesarios.

## ¿Se puede hacer en 3D?

Sí, pero cada personaje necesitaría un modelo tridimensional preparado y revisado; una foto no basta para garantizar el parecido. Esta primera versión usa ilustraciones y un efecto sutil de profundidad CSS sobre la escena final. El siguiente paso más sencillo es un belén **2.5D** con los PNG en capas. No hay visor ni modelos 3D reales implementados.

## Estructura y privacidad

```text
AGENTS.md                     Instrucciones para continuar con otra IA
BRIEF.md                      Resumen del reparto y decisiones
PROMPT-PARA-OTRA-IA.md         Relevo anterior (AGENTS.md es la referencia actual)
references/originals/         13 fotos y un vídeo privados de referencia
references/selection.json     Metadatos privados de Photos Picker
download-references.sh        Descarga ya utilizada por el usuario
web/                          Única carpeta preparada para servir o publicar
```

**No publiques la raíz del proyecto ni `references/`.** Tampoco subas al repositorio las fotografías, el manifiesto de Picker o sus URL temporales. La web no consulta Google Photos ni incorpora las fotos personales. No está desplegada.

## Publicar en GitHub Pages

El workflow [.github/workflows/pages.yml](.github/workflows/pages.yml) comprueba el sitio y publica **solo `web/`** al subir cambios de esa carpeta a `main`. También se puede lanzar manualmente desde **Actions → Publicar en GitHub Pages → Run workflow**.

Antes del primer despliegue, selecciona **Settings → Pages → Build and deployment → Source → GitHub Actions** en el repositorio. No necesita secretos adicionales.

URL prevista: https://ateeducacion.github.io/belen-ate-26-27/

La portada incluye metadatos Open Graph y Twitter con `web/assets/og-image.jpg` (JPEG ligero generado desde `og-image.png`; debe pesar menos de 300 KB para que WhatsApp la muestre) para las vistas previas en redes. Si cambias de repositorio o dominio, actualiza las URL absolutas de `canonical`, `og:url`, `og:image` y `twitter:image` en `web/index.html`. Las redes pueden conservar en caché una vista previa anterior.

La cabecera muestra el símbolo oficial aTe en blanco y con fondo transparente mediante CSS. El pie incluye el logo completo con las islas en sus colores originales. Sus fuentes y la imagen para redes están documentadas en [ASSETS.md](web/assets/ASSETS.md).

## Comprobación

```sh
node web/check.cjs
```

Comprueba reparto, rutas locales, renderizado de fichas, búsqueda, enlaces de descarga y apertura/cierre del diálogo con un DOM mínimo simulado. No sustituye a la revisión visual en un navegador.
