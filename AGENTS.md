# Instrucciones del proyecto: Belén ATE

> **Estado vigente:** lee primero [RELEVO-ACTUAL.md](RELEVO-ACTUAL.md); prevalece sobre los apartados históricos de este archivo.

## Últimas decisiones — 14-11-2026 (prevalecen sobre el historial)

- **Todas las figuras deben mirar de frente**: cuerpo, rostro y ojos hacia el espectador, cámara a la altura de los ojos. Sin perfil ni tres cuartos, sin cabeza inclinada ni mirada hacia el objeto. Corregir expresamente **Berta y Ernesto**, que quedaron de lado, y **Humberto**, que mira hacia abajo. Revisar también las otras 14 figuras.
- Mantener parecido, edad, gafas, peinado, vestuario, objeto y estilo de miniatura. Usar la figura actual como referencia de edición y el recorte facial confirmado. No regenerar el reparto entero por defecto.
- El prompt anterior permitía hasta 10 grados de giro: esa concesión queda anulada. Añadir: «Strictly straight-on front view, shoulders and hips facing camera, upright head, both eyes looking directly forward at eye level; no profile, no three-quarter angle, no downward gaze».
- Ofrecer **Realista / Figurita** (nombre amable para la versión compacta o «enanito»). Hay una prueba de ambos estilos para Francis; no están generadas ambas versiones de las 17 personas. La figurita sigue siendo el estilo del belén.
- Preferencia del usuario: usar el modelo más económico que ha seleccionado. No cambiar a otro más caro ni lanzar generaciones adicionales solo para guardar el estado. El agente no puede cambiar por sí mismo el modelo de esta conversación.
- El usuario ha pedido guardar todo para continuar. **Las correcciones frontales están pendientes; no afirmar que ya están hechas.** No publicar estos borradores como definitivos.

Lee [ESTADO-PARA-CONTINUAR.md](ESTADO-PARA-CONTINUAR.md) para los archivos existentes y el siguiente paso exacto.

## Reglas de trabajo

- Mantén esta web estática y sin dependencias salvo necesidad demostrada. Lee `README.md` antes de editar.
- Las ramas Git deben llamarse en inglés con prefijo `feature/` o `hotfix/`. Nunca `codex/`.
- Usa Context7 para consultar documentación actual de bibliotecas, SDK, APIs o CLI cuando vayas a utilizarlos.
- Sirve y publica únicamente `web/`. `references/` contiene fotografías personales y metadatos privados: nunca los copies al sitio ni los incluyas en un despliegue.
- El despliegue preparado para GitHub Pages está en `.github/workflows/pages.yml`: publica `web/` desde `main`. Las URL sociales apuntan a `https://ateeducacion.github.io/belen-ate-26-27/`; actualízalas si cambia el destino. Mantén el logo oficial sin deformarlo y consulta `web/assets/ASSETS.md`.
- Publicación: el sitio está en GitHub Pages (repo `ateeducacion/belen-ate-26-27`, https://ateeducacion.github.io/belen-ate-26-27/). El workflow despliega `web/` en cada push a `main`. Publica solo cuando el usuario lo pida; cuando lo pide, quiere el push directo a `main`. Sube únicamente `web/`, `README.md` y código necesario: nunca `references/`, `output/`, `herramientas/` ni los documentos de relevo (mencionan material privado). Sin líneas de atribución de IA en commits ni PR.
- Verifica los cambios con `node web/check.cjs`. Comprueba visualmente móvil y escritorio cuando el navegador esté disponible.
- El reparto y las referencias están confirmados en `INSTRUCCIONES-SIGUIENTES.md`. Mantén Fran Mateos y Francis separados; la grafía es Cristian.

## Web: cómo está hecha y cómo tocarla (15-11-2026)

Sitio estático sin dependencias ni build. Es un recorrido de scroll: portada con zoom al portal → «Este año el belén somos nosotros» → cinco capítulos con carrusel → travelling por el belén completo → felicitación → «Tu lámina» (búsqueda, fichas, descargas).

**Archivos**

- `web/content.js`: único sitio donde se editan los datos. `people` (17 fichas: `image`, `sheet`, versión realista), `scene`, `collection`, `chapters` (qué personas salen en cada capítulo, título, frase, colores `bg`/`accent`) y `extras` (el Niño, que no tiene lámina). Deja `null` donde falte material; no enlaces archivos inexistentes.
- `web/story.js`: monta el desfile y los capítulos a partir de `chapters`. Incluye la alternativa en JS para navegadores sin scroll-driven animations (se fuerza con `?js` en la URL).
- `web/app.js`: fichas, búsqueda, diálogos y descargas. `thumb(person)` convierte `figuras/x.png` en `figuras/web/x.webp`.
- `web/styles.css`: todo el movimiento sale de la propiedad `--p` (0→1) de cada elemento con `data-p` (`view` = mientras cruza la pantalla, `pin` = mientras está anclado). Con `prefers-reduced-motion` todo queda estático.
- `web/check.cjs`: comprobación obligatoria (`node web/check.cjs`).

**Decisiones del usuario sobre la experiencia (no deshacer)**

- Tiene que ser espectacular en móvil, pero sin marear: los carruseles avanzan **a pasos**, una figura cada vez, con pausa en la primera y la última. No volver al desplazamiento continuo.
- Las figuras de los capítulos **no son pulsables ni llevan «Ver lámina»**: ahí solo se sigue bajando. Las láminas se abren únicamente en «Tu lámina».
- Cada persona aparece exactamente una vez en `chapters` (lo verifica `check.cjs`).
- El Niño es una placa tipo Arduino graciosa (genérica, sin logos ni marcas), a petición del usuario: «Niño tecnológico» en `extras.nino`. Si se regenera, mantener esa idea y rehacer también su WebP y el belén panorámico para que coincidan.

**Imágenes**

- La página carga copias WebP ligeras; los PNG y PDF originales se quedan para ampliar y descargar. Al cambiar o añadir una figura, regenera su copia: `cwebp -q 82 -alpha_q 90 -resize 0 960 web/assets/figuras/x.png -o web/assets/figuras/web/x.webp`. Lo mismo para `background.webp`, `belen-ate-16-9.webp` (2560 de ancho) y las dos estampas.
- Imagen para compartir: `web/assets/og-image.jpg`, 1200 × 629 y **menos de 300 KB** (WhatsApp no muestra la vista previa con imágenes pesadas). Se genera desde `og-image.png`: `sips -s format jpeg -s formatOptions 70 --resampleWidth 1200 og-image.png --out og-image.jpg`. Las URL de `og:image`, `twitter:image`, `og:url` y `canonical` en `index.html` son absolutas. WhatsApp guarda en caché: para probar, comparte la URL con `?v=2`.
- `web/assets/background.png` es un portal vacío de ambiente, no el belén del equipo (prompt en `web/assets/BACKGROUND-PROMPT.md`). El belén panorámico lo compone `herramientas/crear-entregables.swift` desde `output/figuras/`.

**Verificación antes de publicar**

1. `node web/check.cjs`.
2. `python3 -m http.server 8765 --directory web` y revisar a 390 × 844 y 1440 × 810, también con `?js`. Comprobar que la última figura de cada capítulo queda centrada y que no hay scroll horizontal.
3. Tras el push, confirmar que el despliegue de Pages termina bien (`gh run list -R ateeducacion/belen-ate-26-27`).

No hay modelos 3D reales; la prueba 360° de un personaje sigue sin resolver (ver `output/README.md`).

## Contexto de relevo y producción pendiente

Continúa este proyecto en `/Users/ernesto/Dropbox/Trabajo/ate/belen`.
Haz el trabajo hasta producir los archivos finales, aprovechando las referencias ya descargadas. Habla en español. No vuelvas a empezar la configuración de Google ni pidas al usuario que repita lo que ya está hecho.

## Objetivo y decisiones del usuario

### Estilo confirmado por el usuario

El usuario ha adjuntado las dos láminas originales y confirmado que quiere **esas figuritas de belén con apariencia de miniaturas 3D**, no personas con proporciones realistas vestidas con túnica. Referencias locales privadas: `references/style-sheet-a.png` y `references/style-sheet-b.png`. Usa cabeza grande y reconocible, cuerpo compacto (unas 3–4 cabezas de alto), botas/manos robustas, peana circular de terracota, ropa esculpida y acabado mate pintado a mano. Conserva el vestuario y atributos de esas láminas, mejorando el rostro con las fotografías. La prueba de adulto de proporciones naturales en `output/video/pilot-figure-draft.png` queda descartada como dirección visual.

Francis está confirmado por las referencias posteriores de `INSTRUCCIONES-SIGUIENTES.md`. Su figura debe seguir la celda inferior izquierda de la segunda lámina: músico con timple, túnica ocre corta, mangas crema, manto rojizo, botas y peana. No volver a pedir esa confirmación. La prueba 360° real debe partir de la figurita correcta, no del adulto realista anterior.

Queremos un belén ilustrado con los compañeros de ATE, reconocibles por sus rostros. Los primeros diseños del chat anterior tenían poco parecido. La prioridad es mejorar la fidelidad con fotos reales de referencia.

El usuario ha descartado la impresión 3D: NO se necesitan STL, mallas ni preparación para impresora. Quiere:

1. Una lámina individual A4 vertical para cada uno de los 17 compañeros.
2. Un PDF de exactamente dos páginas con el conjunto de las 17 láminas, con nombres legibles; se puede distribuir 9 y 8.
3. Una imagen grande del belén completo en formato panorámico 16:9.
4. Las piezas preparadas para montar después un vídeo 16:9: cada figura por separado en PNG con transparencia real, fondo limpio separado y elementos que convenga animar aparte (estrella, etc.). No se ha pedido terminar el vídeo todavía.

Usa el mismo diseño de cada personaje en todos los entregables, evitando regenerarlo independientemente para cada composición. Mantén rasgos y edad aparente de las referencias, sin convertir a todo el mundo en caras genéricas. Recupera el estilo previo si puedes verlo en el chat; si no, elige una ilustración cálida y coherente con rostros detallados, sin asumir que se desea estética de render 3D. No inventes nombres completos ni año de celebración.

## Contexto anterior y reparto provisional

Chat compartido: https://chatgpt.com/share/6af83c81-b998-83eb-8789-648854b42605

Ese enlace mostró principalmente la última respuesta con el reparto. También hay una pestaña del chat original titulada «Modelo 3D del Belén». El usuario no ha cambiado el reparto, pero el chat lo presentaba como provisional:

| Ref. | Persona | Personaje |
| --- | --- | --- |
| A1 | Alfredo | Baltasar, con cofre de mirra |
| A2 | Leo | Tejedora |
| A3 | Luis | Melchor, con cofre de oro |
| A4 | Ivonne | María |
| A5 | Roser | Panadera |
| A6 | Santi | Gaspar, con recipiente de incienso |
| A7 | Berta | Pastora con cesta de ofrendas |
| A8 | Fran Mateos | Pastor con leña |
| A9 | Cristian | José |
| B1 | Luz | Ángel anunciador |
| B2 | Humberto | Pastor con farol |
| B3 | Celeste | Pastora con cordero |
| B4 | Ernesto | Pastor del cayado |
| B5 | Yanira | Ángel de la estrella |
| B6 | Carlos | Carpintero |
| B7 | Francis | Músico con timple |
| B8 | Elisa | Alfarera |

Niño Jesús adicional; portal y animales aparte. No atribuyas rasgos étnicos por el papel de un Rey: conserva el aspecto de la persona de referencia.

## Material local disponible

- `references/originals/`: 13 fotos JPEG y un vídeo MP4, descargados correctamente por el usuario mediante gog. Empieza revisando estos archivos; no hace falta descargarlos otra vez.
- `references/selection.json`: manifiesto con nombres, dimensiones, identificadores de Picker y metadatos. Las URL temporales pueden caducar; los originales locales ya están disponibles.
- `references/IMG-20250723-WA0027.jpg`: referencia adicional de 2048 × 1536. Su panel de Photos mostraba las etiquetas Ernesto Serrano, Elisa Piñero ATE e Ivonne ATE, sin correspondencia confirmada entre etiquetas y posiciones.
- `download-references.sh`: script que ya se ejecutó para descargar los 14 archivos. No es una herramienta de búsqueda de toda la fototeca.
- `BRIEF.md`: resumen inicial, actualizado al final de este relevo.

Se han inspeccionado cuatro fotos: `IMG-20261111-WA0010.jpg` (retrato con gafas de sol), `IMG-20261111-WA0017.jpg` (grupo), `IMG-20261112-WA0012.jpg` (tres personas) y `IMG-20261112-WA0017.jpg` (grupo con tres personas en primer plano). No se han asignado nombres a sus rostros. Revisa las demás: algunas son originales de Pixel 8 de unos 10–12 MP, potencialmente mejores para detalle. Las gafas oscuras, el desenfoque y los rostros pequeños limitan el parecido.

## Última petición: buscar más referencias usando las etiquetas existentes

El usuario ha señalado esta foto de grupo y dice que sus miembros ya están identificados en Google Photos:

https://photos.google.com/search/CgpJdm9ubmUgQVRFGikKJ0FGMVFpcE5fUW5tem9HZmNBU2VQTU1IcnlWbGhZRmxwckM4c0JZTSIxEi8KLQorCikSJ0FGMVFpcE5fUW5tem9HZmNBU2VQTU1IcnlWbGhZRmxwckM4c0JZTSixwsnNnTQ%3D/photo/AF1QipNnN85iPjzqfvvKOzDSTh_ooa0Pzub6pXThNqKf

La última lectura del navegador SÍ consiguió abrirla y leer su panel Información. Datos: `IMG-20260904-WA0049.jpg`, 4 de septiembre de 2026, 2048 × 1536, unos 252,5 KB. Todavía no está descargada en esta carpeta.

En «Personas» aparecen enlaces con estas etiquetas, que puedes pulsar para acceder a las fotos agrupadas por Google:

- Ernesto Serrano
- Yanira CEP Gran Canaria
- Elisa Piñero ATE
- Ivonne ATE
- Luis Portela ATE
- Luz ATE
- Celeste ATE
- Roser Ate
- Carlos Morales ATE
- Christian ATE
- Fran ATE
- Victor DG
- Humberto ATE
- Nati DG
- Francis ATE
- Alfredo ATE
- Santi ATE
- Berta ATE

Atención: la etiqueta dice «Christian», mientras que el reparto anterior dice «Cristian». Confirma la grafía para la lámina. «Leo» no aparece en esta lista. Victor DG y Nati DG están etiquetados pero no forman parte del reparto de 17; no añadas sus figuras por tu cuenta. Tampoco asumas que «Fran ATE» y «Francis ATE» son intercambiables.

Usa los nombres y agrupaciones existentes de Photos como información proporcionada por la aplicación. No identifiques personas comparando caras entre fotos ni adivines correspondencias por parecido. Si falta asociar nombre y posición, pide al usuario una aclaración concreta con una referencia visual numerada.

Busca una o dos buenas referencias por persona: rostro grande, enfocado, buena luz, frontal y tres cuartos si existe. Descarga el original y conserva fuente y nombre. No hace falta acumular decenas de imágenes de la misma persona.

## Acceso al navegador y gog: estado real

El usuario autoriza buscar y descargar referencias de su Google Photos en Chrome y usar gog. Ha aceptado dejar Chrome libre mientras se trabaja. No ha autorizado publicar fotos, crear enlaces compartidos ni enviarlas a otras personas.

Chrome está conectado con el perfil Ernesto. La conexión de pestañas por extensión fallaba con un error interno relativo a `timeoutMs`. El control nativo de la aplicación Google Chrome sí pudo leer etiquetas, navegar y descargar una foto, aunque hubo estados desactualizados, capturas vacías e interrupciones cuando cambiaba la pestaña. La ÚLTIMA llamada nativa funcionó y mostró el panel de la foto de grupo arriba descrita. Prueba primero ese acceso y observa de nuevo los controles antes de actuar; no reutilices índices de accesibilidad de una sesión anterior. Si los resultados de navegación no actualizan el contenido, una recarga mediante el botón de Chrome funcionó en un caso.

gog v0.48.0 está instalado. El usuario completó la autorización de Photos Picker en SU terminal. Desde el entorno del agente, el llavero devolvía «refresh token missing», mientras que en el terminal del usuario `gog auth doctor` mostraba 3 tokens legibles y configuración correcta. La ejecución fuera del sandbox fue rechazada por la política del entorno, pese a la autorización del usuario. No prometas que puedes saltarte ese bloqueo y no hagas que el usuario autorice otra vez sin necesidad.

Hubo un error de Google «malformed» al autorizar. Se encontró el problema reportado en https://github.com/openclaw/gogcli/issues/1334. El usuario consiguió avanzar con un enlace OAuth nuevo quitando únicamente `&include_granted_scopes=true`. Después creó la sesión Picker y descargó los archivos. Esto es historia del problema, no una tarea pendiente.

Sesión usada para la selección ya descargada: `5161f6ac-9eeb-4d77-a731-0928919e01cb`.

IMPORTANTE: Photos Picker permite seleccionar archivos y descargarlos; no permite buscar libremente toda la fototeca por API. Para ampliar las referencias, usa la web y sus etiquetas. Si gog no puede acceder al llavero del agente, el navegador es la primera alternativa. No extraigas ni solicites tokens como atajo.

## Producción y verificación

1. Revisa los originales locales y la foto de grupo etiquetada. Guarda una tabla de referencia por persona con archivo fuente y correspondencia confirmada.
2. Completa los huecos buscando en los grupos etiquetados; si falta Leo u otra persona, pregunta solo lo necesario.
3. Usa la herramienta de generación/edición de imágenes disponible, con las fotos como referencias explícitas. Conserva los originales. No sustituyas ilustraciones por siluetas o dibujos programáticos.
4. Genera una figura por compañero con detalle facial y una composición reutilizable; comprueba anatomía, objetos, gafas y ausencia de recortes. No cambies la edad aparente ni embellezcas hasta perder los rasgos.
5. Maqueta los A4 con texto limpio fuera de la imagen generada, y compón las dos páginas resumen a partir de los mismos archivos. Entrega PDF listos para imprimir y PNG de las ilustraciones. Apunta a calidad de impresión; informa de la resolución efectiva y no presentes un simple reescalado como detalle nuevo.
6. Compón el belén panorámico con las mismas figuras para evitar cambios de cara. Entrega imagen grande y capas del vídeo, con escalas y nombres consistentes. Transparencia real, sin tablero de ajedrez dibujado.
7. Guarda en `output/` con subcarpetas claras (`laminas`, `resumen`, `belen`, `video`). Incluye un índice y las instrucciones mínimas de uso de las piezas del vídeo. Verifica visualmente todas las páginas y cuenta las 17 personas, sin duplicados ni omisiones.

No hay todavía ilustraciones generadas, PDFs finales ni vídeo preparado. No informes de ellos como terminados. Si hay un bloqueo, conserva lo avanzado y describe el paso exacto que falta. El objetivo principal es completar el belén con mejor parecido, no seguir dedicando turnos a configurar OAuth.

Última corrección del usuario: **Alfredo también debe mirar directamente al frente**, con cuerpo y rostro frontales, cabeza erguida y ojos hacia el espectador. Incluirlo junto con Berta, Ernesto y Humberto en las correcciones explícitas pendientes.

Última indicación: **Santi también debe mirar directamente al frente**. Para Ivonne, elegir otra fotografía confirmada en la que salga más favorecida, nítida y frontal, conservando su parecido y edad. Revisar los recortes disponibles antes de buscar más. Ambas tareas quedan pendientes de edición.
