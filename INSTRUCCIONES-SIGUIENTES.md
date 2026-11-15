# Belén ATE: siguientes pasos

Estado a 14-11-2026. Sustituye la parte de referencias de `PROMPT-PARA-OTRA-IA.md`. El objetivo y los entregables siguen igual: 17 láminas A4, un PDF resumen de 2 páginas, un belén en 16:9 y capas en PNG para el vídeo.

## Decisiones confirmadas por el usuario

| Ref. | Persona (texto de la lámina) | Personaje | Etiqueta en Google Fotos |
| --- | --- | --- | --- |
| A1 | Alfredo | Baltasar, con cofre de mirra | Alfredo ATE |
| A2 | Leo | Tejedora | Leocadia ATE |
| A3 | Luis | Melchor, con cofre de oro | Luis Portela ATE |
| A4 | Ivonne | María | Ivonne ATE |
| A5 | Roser | Panadera | Roser Ate |
| A6 | Santi | Gaspar, con incienso | Santi ATE |
| A7 | Berta | Pastora con cesta de ofrendas | Berta ATE |
| A8 | Fran Mateos | Pastor con leña | Fran ATE |
| A9 | **Cristian** (no «Christian») | José | Christian ATE |
| B1 | Luz | Ángel anunciador | Luz ATE |
| B2 | Humberto | Pastor con farol | Humberto ATE |
| B3 | Celeste | Pastora con cordero | Celeste ATE |
| B4 | Ernesto | Pastor del cayado | Ernesto Serrano |
| B5 | Yanira | Ángel de la estrella | **Yanira CEP Gran Canaria** (no es Yanira Duque ATE) |
| B6 | Carlos | Carpintero | Carlos Morales ATE |
| B7 | Francis | Músico con timple | Francis ATE |
| B8 | Elisa | Alfarera | Elisa Piñero ATE |

Las demás personas etiquetadas no se añaden: Victor DG, Nati DG, Norberto, Freddy, Sergio Fortes, Jose León, Salva CEP, Omar Consejería, Pablo ATE formación y Elisa Daer ATE.

## Referencias: dónde está todo

- **`references/caras-por-persona/`**: recortes de cara ya confirmados, nombrados `Ref-Nombre-fuente.jpg`. Son la entrada principal para ilustrar. Hay una vista general de todos en `00-resumen.jpg`.
- `references/REFERENCIAS.md`: tabla completa con archivo fuente, etiquetas, posiciones confirmadas y resoluciones.
- `references/originals/` (Picker) y `references/etiquetadas/` (descargas por etiqueta): fotos originales sin tocar.
- `references/caras-numeradas/`: fotos con las caras numeradas (detección automática, de izquierda a derecha).
- `references/marcar-caras.html`: página local para que el usuario marque quién es cada número. Al terminar copia el resultado y lo pega en el chat.

Todas las posiciones en fotos de grupo las ha marcado el usuario. Ninguna identidad se ha deducido comparando caras.

## Referencias: COMPLETAS

Las 17 personas tienen al menos un recorte de cara confirmado, de unos 570 px o más. Son 36 recortes en `references/caras-por-persona/`, y todas las posiciones las marcó el usuario. Para cada persona, elige el recorte más grande, frontal y nítido (consulta `00-resumen.jpg`). Los recortes de perfil o con gafas de sol son solo de apoyo.

Si más adelante hace falta otra referencia:
1. Busca la etiqueta en Google Fotos, numera las caras con `caras` y añade las hojas a `references/marcar-caras.html`, en el array `SHEETS`, para que el usuario las marque.
2. Recorta las caras confirmadas y guárdalas en `caras-por-persona/`.
   - Las herramientas están en `herramientas/`. Se compilan con `swiftc -O -o /tmp/recorte herramientas/recorte.swift`, y lo mismo para `caras.swift` y `montaje.swift`.
   - Uso: `recorte salida.jpg entrada.jpg N`, donde N es el número que aparece en la hoja de `caras-numeradas/`. La detección es la misma que la de las hojas, así que los números coinciden.
   - Uso de montaje: `montaje salida.jpg caras-por-persona/*.jpg`.
3. Actualiza `REFERENCIAS.md` y regenera `caras-por-persona/00-resumen.jpg` con `montaje`.

## Producción (actualizada: borradores generados, revisión pendiente)

Ya existen los 17 PNG de figuritas y una prueba realista de Francis, PDF individuales, resumen de dos páginas y composición 16:9 en `output/`. Son **borradores pendientes de corregir orientación y revisar visualmente**. Consulta `ESTADO-PARA-CONTINUAR.md`; no repetir las generaciones existentes sin necesidad.

Orden de trabajo (sigue valiendo lo de `PROMPT-PARA-OTRA-IA.md` § «Producción y verificación»):
1. Una figura por persona, de cuerpo entero, con fondo liso o transparente y con su personaje y objeto. Ese archivo es el maestro de la figura y se reutiliza en todo.
2. Láminas A4 verticales con el nombre en texto limpio, maquetado fuera de la imagen. Van en `output/laminas/`.
3. PDF resumen de 2 páginas (9 + 8) a partir de las mismas figuras, en `output/resumen/`.
4. Belén panorámico 16:9 compuesto con esas mismas figuras, en `output/belen/`.
5. Capas para el vídeo: cada figura en PNG con transparencia real, el fondo aparte y la estrella aparte. Van en `output/video/` con un índice de uso.
6. Verificar visualmente que estén las 17 personas, sin duplicados.

## Notas de acceso

- La cuenta con las etiquetas es **erseco@gmail.com**, en el Chrome «Browser 2» (equipo Bender M5). El otro Chrome tiene cuentas de Educación sin estas fotos y el usuario pidió no usarlo.
- Descargar con Mayús+D en la vista de foto. Las descargas múltiples ya están permitidas.
- Las fotos con movimiento (`.MP`) abren un vídeo con Mayús+D. Se guardan haciendo `fetch` de la URL de la imagen con `=w<ancho>-h<alto>` y un enlace `download`.
- La búsqueda «Alfredo ATE» incluye memes de un político, que son etiquetas erróneas de Google.

## Últimas decisiones — 14-11-2026 (prevalecen sobre el historial)

- **Todas las figuras deben mirar de frente**: cuerpo, rostro y ojos hacia el espectador, cámara a la altura de los ojos. Sin perfil ni tres cuartos, sin cabeza inclinada ni mirada hacia el objeto. Corregir expresamente **Berta y Ernesto**, que quedaron de lado, y **Humberto**, que mira hacia abajo. Revisar también las otras 14 figuras.
- Mantener parecido, edad, gafas, peinado, vestuario, objeto y estilo de miniatura. Usar la figura actual como referencia de edición y el recorte facial confirmado. No regenerar el reparto entero por defecto.
- El prompt anterior permitía hasta 10 grados de giro: esa concesión queda anulada. Añadir: «Strictly straight-on front view, shoulders and hips facing camera, upright head, both eyes looking directly forward at eye level; no profile, no three-quarter angle, no downward gaze».
- Ofrecer **Realista / Figurita** (nombre amable para la versión compacta o «enanito»). Hay una prueba de ambos estilos para Francis; no están generadas ambas versiones de las 17 personas. La figurita sigue siendo el estilo del belén.
- Preferencia del usuario: usar el modelo más económico que ha seleccionado. No cambiar a otro más caro ni lanzar generaciones adicionales solo para guardar el estado. El agente no puede cambiar por sí mismo el modelo de esta conversación.
- El usuario ha pedido guardar todo para continuar. **Las correcciones frontales están pendientes; no afirmar que ya están hechas.** No publicar estos borradores como definitivos.

Lee [ESTADO-PARA-CONTINUAR.md](ESTADO-PARA-CONTINUAR.md) para los archivos existentes y el siguiente paso exacto.


Última corrección del usuario: **Alfredo también debe mirar directamente al frente**, con cuerpo y rostro frontales, cabeza erguida y ojos hacia el espectador. Incluirlo junto con Berta, Ernesto y Humberto en las correcciones explícitas pendientes.

Última indicación: **Santi también debe mirar directamente al frente**. Para Ivonne, elegir otra fotografía confirmada en la que salga más favorecida, nítida y frontal, conservando su parecido y edad. Revisar los recortes disponibles antes de buscar más. Ambas tareas quedan pendientes de edición.
