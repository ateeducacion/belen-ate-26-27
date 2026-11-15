# Prompt para rehacer las figuras del Belén ATE

Para la IA que genera las imágenes. Lee antes `ESTADO-PARA-CONTINUAR.md` y `AGENTS.md`. Este documento sustituye los criterios de estilo de `output/production.json`.

## Qué falla en la versión actual (`output/figuras/`, `output/belen/`)

1. **Parecen una foto pegada sobre una figura.** La cara tiene piel fotográfica, con poros, brillo y la luz de la foto original, y el cuerpo es de resina mate pintada. Los dos materiales no casan y el resultado se ve como una cabeza recortada sobre un muñeco (Humberto, Carlos, Ernesto, Yanira). Es lo que más desentona.
2. **Cabeza demasiado grande y sin cuello**, como un muñeco de cabeza bamboleante. La lámina original (`references/style-sheet-a.png`) tiene una proporción más contenida y la cabeza integrada en el cuerpo.
3. **Expresiones forzadas o deformadas.** Sonrisas exageradas, ojos que miran a otro lado y alguna boca torcida. Varias personas parecen mayores o más caricaturizadas que en sus fotos.
4. **Cuerpos clónicos.** Casi todos llevan la misma túnica crema con manto, en tonos parecidos de mostaza, oliva y teja. A tamaño pequeño no se distinguen por la silueta.
5. **Resolución insuficiente para A4.** Los PNG miden 1024×1536 y la cara ocupa unos 300 px. Un A4 a 300 ppp necesita 2480×3508; ahora se imprimiría ampliado.
6. **Belén 16:9 sin escena.** Las figuras están pegadas en dos filas. La fila de arriba flota en el cielo y delante del tejado, todas tienen el mismo tamaño aunque estén a distinta profundidad, no hay sombras de contacto, el portal está vacío, María y José no están junto al Niño, y el Niño es diminuto y queda delante de todos.

## Dirección artística (elige una y aplícala a las 17)

**A. Figurita de belén tallada y pintada a mano (recomendada, mantiene la idea actual):**
- La cara se **esculpe y pinta en el mismo material** que el cuerpo: terracota o madera policromada mate, con pinceladas visibles y sin poros ni brillo fotográfico.
- El parecido se consigue con la forma de la cara, el peinado, las gafas, la barba, las cejas y la sonrisa característica, no copiando la foto.
- Proporción de unas 4,5 cabezas de alto. Cuello visible y hombros proporcionados.
- Peana redonda baja.

**B. Ilustración de cuento en gouache o acuarela:** más cálida, con trazo pintado y fondo integrado. Pierde el aspecto de figura de belén.

## Reglas para cada figura

- **Totalmente frontal:** cuerpo, cabeza y ojos mirando al espectador a la altura de los ojos. Expresión amable y natural, con la sonrisa propia de la persona y sin exagerarla.
- **Edad, complexión, gafas, peinado y vello facial idénticos a las fotos.** Ni rejuvenecer ni caricaturizar.
- **Referencias:** usa 2 o 3 recortes por persona de `references/caras-por-persona/`, frontales y nítidos, y nunca solo uno. **Describe además los rasgos con palabras** en el prompt. Así el modelo traduce el parecido al estilo en vez de pegar la foto.
- **Siluetas distintas por personaje:**

  | Personaje | Rasgos de silueta |
  | --- | --- |
  | Reyes | Coronas y tocados diferentes entre sí; mantos largos con brocado |
  | Ángeles | Alas grandes y túnica clara; pueden ir algo elevados |
  | Pastores | Zurrón, gorro o pañuelo y capas cortas |
  | Oficios | Delantal y herramientas reconocibles |

  Paleta común (teja, oliva, ocre, azul María, crema y oro viejo), pero cada personaje con su color dominante.
- **Generación en alta resolución:** al menos 2048×3072 en la propia generación, no ampliando después. Fondo transparente real, cuerpo entero, sin recortes, sin texto ni marco y con la misma luz cálida suave desde arriba a la izquierda en todas.
- **Primero 3 pruebas** (Humberto, Celeste y Carlos) para que el usuario las apruebe. Solo después, las 17.

## Plantilla de prompt por figura (en inglés, que suele funcionar mejor)

```
Hand-carved and hand-painted Christmas nativity figurine of a real person, single full-body statue, front view, facing the camera, eyes looking at the viewer at eye level.
Material: matte painted terracotta / polychrome wood. The FACE IS SCULPTED AND PAINTED IN THE SAME MATERIAL as the body, with visible brushwork. No photographic skin, no pores, no photo lighting, no pasted face.
Proportions: about 4.5 heads tall, visible neck, natural shoulders, compact but not chibi. Low round terracotta base.
Likeness from the attached reference photos (same person in all of them): {RASGOS}. Keep real age, face shape, hairstyle, glasses and facial hair. Natural friendly expression with this person's own smile, not exaggerated. Do not beautify, de-age or caricature.
Role: {PERSONAJE Y OBJETO}. Dominant colour: {COLOR}.
Soft warm studio light from upper left, consistent across the series. Transparent background, entire figure and base visible, no text, no frame, no glow. Output at least 2048x3072.
```

`{RASGOS}` es una frase concreta por persona, por ejemplo:

| Persona | `{RASGOS}` |
| --- | --- |
| Humberto | bald man in his fifties, short grey goatee and moustache, round face, warm wide smile, small mole on left forehead |
| Celeste | woman with long wavy light-blonde hair and side fringe, fair skin, wide bright smile |

Escribe la de cada persona mirando sus recortes, sin inventar.

## Belén 16:9

Monta la escena como un belén real fotografiado, no como una tira de pegatinas:
- **Cerca del pesebre, dentro del portal iluminado:** el Niño, a la escala del resto, con María (Ivonne) y José (Cristian).
- **Reyes:** llegan desde la izquierda en primer plano.
- **Pastores:** a la derecha.
- **Ángeles:** sobre el tejado del portal o junto a la estrella. Son los únicos que pueden ir elevados.
- **Oficios:** en el pueblo, en planos intermedios.
- **Perspectiva:** las figuras del fondo, más pequeñas, y todas apoyadas en el suelo con sombra de contacto.
- **Luz:** la misma luz cálida del portal sobre todas las figuras.
- **Identidades:** usa las figuras ya aprobadas, sin regenerarlas dentro de la escena, para que no cambien las caras. Vuelve a contar 17 personas más el Niño.
