# Relevo vigente — Belén ATE

El usuario quiere una estampa de belén integrada y con las caras **exactas de las figuritas**, además de láminas A4, versiones realistas, resumen y web. Las instrucciones de este documento sustituyen cualquier estado anterior contradictorio en AGENTS.md, ESTADO-PARA-CONTINUAR.md y output/REVISION-2026-11-15.md.

## Prioridad pendiente

La estampa generada queda integrada pero cambia caras. NO afirmar que conserva las caras exactas. La composición `output/belen/belen-ate-16-9.png` utiliza los PNG originales sin cambiar caras, pero sus peanas, sombras y escalas se ven superpuestas. Mejorar la integración mediante composición de los PNG maestros con perspectiva y sombras, sin regenerar ni alterar caras. Preservar 17 personas y Niño, colocar María y José junto al Niño, Reyes a la izquierda y pastores a la derecha. Usar el ambiente cálido de la estampa como inspiración.

Pruebas nuevas para revisar: `output/belen/revision-caras/integrada.png` y `realista.png`. Son ediciones generativas con la vista general de figuras como referencia; **no se han inspeccionado ni se garantiza parecido**. No se han incorporado a la web. Las pruebas anteriores son `output/belen/estampa-figuritas-prueba.png` y `estampa-realista-prueba.png`, incluidas en la web como interpretaciones, no identidades exactas.

## Aprobaciones y referencias

El usuario aprobó la Berta realista `output/correcciones-15/berta-realista.png`, ya integrada en `output/figuras/realistas/berta.png`. Su nueva referencia facial confirmada es `references/caras-por-persona/A7-Berta-PXL_20260904_184717727.jpg`. Humberto, Carlos, Celeste y Ernesto tienen figuritas aprobadas. Ernesto usa la referencia confirmada `references/caras-por-persona/B4-Ernesto-PXL_20261023_071852785.jpg` y maestro `output/figuras/ernesto.png`. Berta figurita: `output/revision-final/berta.png`. Correcciones Francis, Luz e Ivonne realista están en `output/correcciones-15/` y se copiaron a maestros. No volver a cambiar rostros aprobados sin necesidad.

## Web y entregables

**15-11-2026 (tarde):** la web se rehízo como recorrido de scroll con parallax (portada → capítulos → belén → láminas). Revisada en navegador a 390×844 y 1440×810, también con `?js`. Detalles en README.md y en AGENTS.md («Web: cómo está hecha y cómo tocarla»). **Publicada** en GitHub Pages desde `main`.

`web/index.html` se abre localmente. `web/content.js` enlaza 17 figuritas y 17 realistas, cada una con PDF A4; existe resumen de dos páginas. En la sección belén hay una composición con figuras originales y dos estampas generadas. Todas se ajustan al ancho y se abren en un diálogo lightbox; Escape cierra el diálogo nativo. `node web/check.cjs` pasó tras el cambio. No se ha hecho revisión visual en navegador para el lightbox.

`output/figuras/` contiene maestros y `output/figuras/realistas/` las realistas; `output/laminas/`, `output/resumen/`, `output/video/` y `output/belen/` contienen entregables. `herramientas/crear-entregables.swift` reconstruye láminas/resumen/composición, pero usa una colocación manual todavía mejorable. Las figuras generadas son aproximadamente 1024×1536, por debajo de A4 a 300 ppp; no decir que una ampliación añade detalle. Los elementos PNG están disponibles para vídeo, no se ha producido vídeo. Modelo 3D real 360° no generado.

## Publicación y privacidad

Publicado en GitHub Pages: repo `ateeducacion/belen-ate-26-27`, https://ateeducacion.github.io/belen-ate-26-27/. Cada push a `main` despliega `web/`. El `main` local está al día con el remoto. Los documentos de relevo, `herramientas/` y los cambios locales de `AGENTS.md` y `BRIEF.md` no se suben. El sitio pesa unos 281 MB (hay un PDF de 60 MB): pendiente de aligerar.

**Nunca publicar `references/`, fotos, recortes ni metadatos privados**; solo `web/` y archivos de código necesarios. `output/` y `references/` están ignorados por Git: si se continúa en otra máquina, trasladarlos por canal privado. No solicitar tokens ni credenciales.

## Preferencias

Responder en español. Ramas en inglés con prefijo `feature/` o `hotfix/`, nunca `codex/`. El usuario ha pedido continuar hasta completar el trabajo y autorizó publicar. No pedir aprobación de nuevo. Para nuevas tareas HTML/CSS/JS consultar modern-web-guidance: la última consulta falló por falta de caché/red. Aplicar AGENTS.md salvo donde su historial contradiga este relevo.

## Actualización: placa y Rosy

El usuario eligió sustituir al Niño por una placa de microcontrolador dormida. `output/figuras/nino-placa.png` es la nueva placa; se copió a `output/figuras/nino.png`, web/assets/figuras/nino.png y su miniatura WebP. La escena principal y resumen se regeneraron con ella. Las dos estampas generadas anteriores siguen incluyendo el Niño tradicional y se identifican como versiones anteriores en la web. Figuras de Alfredo, Berta, Santi y Yanira se sustituyeron por pruebas en `output/pruebas-nuevas-15/`; anteriores en `output/versiones-antes-20261115/`.

El usuario añadió una integrante: **Rosy**, personaje **panadera**. Su posición en las fotos aún no está confirmada. Se preparó `references/rosy/marcar.html`: el usuario pulsará su cara en cada foto y pegará la selección en el chat. No deducir identidad por parecido; usar las coordenadas que indique. `references/rosy/` contiene fotos privadas. Al confirmarla, generar figurita y versión realista, incorporarla como persona 18, adaptar contador, índice de capítulos, láminas, resumen de exactamente dos páginas y composición; tener en cuenta que Roser también es panadera. Comprobar los supuestos fijos de 17 en herramientas/crear-entregables.swift y web/check.cjs.
