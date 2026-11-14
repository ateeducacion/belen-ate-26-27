# Instrucciones del proyecto: Belén ATE

## Reglas de trabajo

- Mantén esta web estática y sin dependencias salvo necesidad demostrada. Lee `README.md` antes de editar.
- Las ramas Git deben llamarse en inglés con prefijo `feature/` o `hotfix/`. Nunca `codex/`.
- Usa Context7 para consultar documentación actual de bibliotecas, SDK, APIs o CLI cuando vayas a utilizarlos.
- Sirve y publica únicamente `web/`. `references/` contiene fotografías personales y metadatos privados: nunca los copies al sitio ni los incluyas en un despliegue.
- El despliegue preparado para GitHub Pages está en `.github/workflows/pages.yml`: publica `web/` desde `main`. Las URL sociales apuntan a `https://ateeducacion.github.io/belen-ate-26-27/`; actualízalas si cambia el destino. Mantén el logo oficial sin deformarlo y consulta `web/assets/ASSETS.md`.
- No publiques automáticamente este proyecto ni subas referencias privadas al repositorio. El usuario ha pedido preparar los archivos en esta carpeta.
- Verifica los cambios con `node web/check.cjs`. Comprueba visualmente móvil y escritorio cuando el navegador esté disponible.
- El reparto sigue siendo provisional. Mantén la diferencia Fran / Francis y confirma Cristian / Christian y la referencia de Leo antes de cerrar las ilustraciones.

## Web ya preparada

`web/index.html`, `styles.css`, `content.js` y `app.js` forman el sitio. La portada dice «ATE les desea Feliz Navidad». Contiene escenario, búsqueda por nombre, 17 fichas, ampliación de ilustraciones mediante diálogo y enlaces de descarga cuando hay archivos disponibles.

`web/assets/background.png` es una ilustración generada de un portal vacío para ambientar el sitio. NO es el belén final del equipo. El prompt de generación está en `web/assets/BACKGROUND-PROMPT.md`.

Para incorporar los entregables, guarda los archivos finales en `web/assets/` y asigna sus rutas relativas en `web/content.js`: `scene` para el belén 16:9, `collection` para el PDF de dos páginas, `image` y `sheet` para la ilustración y el PDF de cada persona. Deja `null` donde el material no esté listo; no añadas enlaces a archivos inexistentes.

La profundidad actual es un efecto CSS muy ligero sobre la escena terminada, desactivado con movimiento reducido. No hay modelos 3D reales. La vía más pequeña para continuar es componer personajes PNG en capas 2D/2.5D. Solo prepara modelos 3D si el usuario confirma esa ampliación; las fotografías por sí solas no proporcionan una geometría fiel.

## Contexto de relevo y producción pendiente

Continúa este proyecto en `/Users/ernesto/Dropbox/Trabajo/ate/belen`.
Haz el trabajo hasta producir los archivos finales, aprovechando las referencias ya descargadas. Habla en español. No vuelvas a empezar la configuración de Google ni pidas al usuario que repita lo que ya está hecho.

## Objetivo y decisiones del usuario

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
