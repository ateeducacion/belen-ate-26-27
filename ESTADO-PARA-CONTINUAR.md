> Estado actualizado: consulta primero [RELEVO-ACTUAL.md](RELEVO-ACTUAL.md). El contenido siguiente conserva el historial y puede estar desactualizado.

# Relevo del Belén ATE — 14 de noviembre de 2026

## Lo siguiente que hay que hacer

El usuario pidió guardar el trabajo y las instrucciones. No se han ejecutado nuevas generaciones después de su petición de corrección. **Todos de frente, incluido rostro y mirada.** Corregir Berta y Ernesto (de lado) y Humberto (mirada hacia abajo); revisar el resto. Mantener las caras, ropa, atributos y miniatura compacta de las láminas originales. No confundir con un giro de la imagen plana.

Preferencia: modelo económico seleccionado por el usuario. No cambiar a un modelo caro por iniciativa propia. El modelo de conversación se selecciona en la aplicación, no mediante archivos del proyecto.

## Archivos conservados

- `references/caras-por-persona/`: 36 recortes confirmados de las 17 personas. No hace falta repetir la búsqueda ni OAuth. Identidades y reparto: `INSTRUCCIONES-SIGUIENTES.md`. Francis está confirmado, Cristian se escribe sin h, Yanira es la de CEP Gran Canaria.
- `references/style-sheet-a.png` y `style-sheet-b.png`: estilo de las dos láminas originales. Miniaturas con cabeza grande, cuerpo compacto y peana circular, acabado mate de terracota/resina pintada.
- `output/figuras/`: 17 PNG maestros nombrados por id, más `nino.png`, `star.png` y `francis-realista.png`. **Borradores, no aprobados como finales.** No borrar antes de corregir.
- `output/production.json`: reparto, fuentes, prompts usados y estado de revisión. Los prompts históricos documentan lo generado; el campo `reviewStatus` y AGENTS.md contienen la corrección vigente que anula los tres cuartos.
- `output/laminas/<id>-a4.pdf`: 17 A4 individuales y `francis-realista-a4.pdf`. Hay pruebas antiguas con “pilot” o “provisional”: son historial, no la entrega actual.
- `output/resumen/belen-ate-dos-paginas.pdf`: borrador de dos páginas, 9 personas + 8 y el Niño adicional.
- `output/belen/belen-ate-16-9.png`: borrador compuesto, 3840 × 2160. El fondo se ha ampliado; no implica más detalle original.
- `output/preview/todas-las-figuras.png`: vista general para revisar.
- `output/video/capas/fondo.png`: fondo separado. Las figuras y estrella están en `output/figuras/`; falta organizar/copiar las capas y su índice para el vídeo.
- `herramientas/crear-entregables.swift`: genera los A4, resumen, composición y vista general desde los PNG maestros y `production.json`, sin dependencias externas. Regenerar después de corregir los maestros.

## Comparación de estilos en la web

El usuario propone mostrar **Realista / Figurita** para comparar el normal y el compacto. Hay prueba realista de Francis; el resto solo tiene figurita. El belén usa figuritas.

`web/index.html`, `web/app.js` y `web/styles.css` tienen preparado el selector para fichas con `realisticImage`. `web/check.cjs` incluye su comprobación. `web/content.js` aún tiene las imágenes y descargas a `null`: **no se han incorporado los borradores a la web**. Para Francis, asignar `image`, `sheet`, `realisticImage` y `realisticSheet` una vez revisados. No mostrar botones que enlacen a archivos inexistentes ni insinuar que todos tienen dos estilos.

## Secuencia de continuación

1. Leer AGENTS.md y las últimas decisiones de INSTRUCCIONES-SIGUIENTES.md.
2. Inspeccionar los PNG actuales antes de editarlos. Corregir primero Berta, Ernesto y Humberto con la herramienta de edición de imágenes y sus referencias confirmadas. Fondo transparente real, cuerpo entero, peana sin recortes. Cara, cuerpo y ojos frontales a la altura del espectador. No modificar la identidad ni convertir todos los rostros en uno genérico.
3. Revisar individualmente los otros 14. Guardar las versiones anteriores antes de sustituir un maestro. Actualizar fuentes/prompts y estado de revisión en `output/production.json`.
4. Regenerar los documentos desde la raíz:

   ```sh
   CLANG_MODULE_CACHE_PATH=/tmp/belen-clang swift -module-cache-path /tmp/belen-swift-cache herramientas/crear-entregables.swift
   ```

5. Renderizar los PDF con `pdftoppm` e inspeccionar cada página; comprobar exactamente 17 personas sin duplicados, resumen de 2 páginas, textos legibles, manos/objetos, transparencia y poses. Los PDF/composición actuales **no tienen revisión visual final completada**.
6. Preparar las capas PNG de vídeo con índice de posiciones/escalas y orden de superposición. No se ha pedido terminar el vídeo.
7. Incorporar solamente ilustraciones finales y PDF a `web/assets/`, asignar rutas relativas en `web/content.js`. Ejecutar `node web/check.cjs` y revisar móvil/escritorio.
8. Guardar localmente; no publicar automáticamente. No copiar fotos originales, recortes, metadatos ni manifiestos privados al sitio.

## 3D y publicación

La figurita es una imagen con aspecto de objeto 3D, no una malla. La prueba 360° real sigue pendiente de un generador adecuado; no presentar una imagen plana girando como modelo. Antes se propuso fal, pero no estaba conectado. No afirmar que ya se ha construido un 360°.

GitHub Pages ya estaba configurado/publicado para la web anterior: https://ateeducacion.github.io/belen-ate-26-27/ . Estos nuevos borradores y cambios están locales, sin publicar. `.git` no admite escritura desde el sandbox; no afirmar que se ha hecho commit/push. Un envío anterior se hizo mediante GitHub API, por lo que HEAD local puede diferir de remoto: leer el estado antes de cualquier nueva publicación y no sobrescribir cambios remotos.

`output/` y `references/` están excluidos de Git pero existen en esta carpeta. Para continuar en otro equipo hay que trasladarlos por un medio privado. Los archivos de instrucciones sí están en la raíz del proyecto.

Última corrección del usuario: **Alfredo también debe mirar directamente al frente**, con cuerpo y rostro frontales, cabeza erguida y ojos hacia el espectador. Incluirlo junto con Berta, Ernesto y Humberto en las correcciones explícitas pendientes.

Última indicación: **Santi también debe mirar directamente al frente**. Para Ivonne, elegir otra fotografía confirmada en la que salga más favorecida, nítida y frontal, conservando su parecido y edad. Revisar los recortes disponibles antes de buscar más. Ambas tareas quedan pendientes de edición.

## Actualización 15-11-2026 — nueva referencia de Ernesto

Buscada en Google Photos con la etiqueta «Ernesto Serrano» y confirmada en el panel Información (única persona etiquetada): `references/etiquetadas/PXL_20261023_071852785.jpg` (Pixel 8, 12,5 MP, frontal, buena luz, sin gafas de sol). Recorte facial: `references/caras-por-persona/B4-Ernesto-PXL_20261023_071852785.jpg`. **Usarla como referencia principal para corregir la figura B4 de frente.** La figura todavía NO está corregida.

## Actualización 15-11-2026 (tarde)

Revisión completa de las 17 figuras vigentes en `output/REVISION-2026-11-15.md`. Pendientes: Francis (estilo antiguo, inclinado), gafas de Luz, manto de Ivonne realista y referencia de Berta. La etiqueta «Berta ATE» solo tiene fotos de grupo. Nada regenerado todavía.
Nueva referencia de Berta, confirmada por el usuario: `references/caras-por-persona/A7-Berta-PXL_20260904_184717727.jpg`.
