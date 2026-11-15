// Solo archivos finales autorizados: nunca enlazar references/ ni las fotos personales.
window.belenContent = {
  scene: 'assets/belen-ate-16-9.png',
  collection: 'assets/belen-ate-dos-paginas.pdf',
  // Recorrido de la portada: cada persona aparece en un único capítulo.
  chapters: [
    { id: 'portal', title: 'El portal', line: 'Donde empieza todo.', bg: '#10243f', accent: '#f2c14e', people: ['ivonne', 'nino', 'cristian'] },
    { id: 'reyes', title: 'Los Reyes', line: 'Vienen de lejos y nunca con las manos vacías.', bg: '#451a4f', accent: '#f5b84b', people: ['alfredo', 'luis', 'santi'] },
    { id: 'angeles', title: 'Los ángeles', line: 'Las buenas noticias siempre llegan desde arriba.', bg: '#0e4a50', accent: '#ffe9a8', people: ['luz', 'yanira'] },
    { id: 'pastores', title: 'Los pastores', line: 'Los primeros en llegar al portal.', bg: '#2c4420', accent: '#f0d27a', people: ['berta', 'fran', 'humberto', 'celeste', 'ernesto'] },
    { id: 'oficios', title: 'Los oficios', line: 'Las manos que hacen que todo funcione.', bg: '#64202a', accent: '#ffd9a0', people: ['leo', 'roser', 'rosy', 'carlos', 'francis', 'elisa'] }
  ],
  extras: { nino: { id: 'nino', name: 'El Niño', role: 'Niño tecnológico · una luz de ilusión', image: 'assets/figuras/nino.png' } },
  people: [
    { id: 'alfredo', name: 'Alfredo', role: 'Baltasar · el regalo de la mirra', image: 'assets/figuras/alfredo.png', sheet: 'assets/laminas/alfredo-a4.pdf', realisticImage: 'assets/figuras/realistas/alfredo.png', realisticSheet: 'assets/laminas/alfredo-realista-a4.pdf' },
    { id: 'leo', name: 'Leo', role: 'Tejedora · historias entre hilos', image: 'assets/figuras/leo.png', sheet: 'assets/laminas/leo-a4.pdf', realisticImage: 'assets/figuras/realistas/leo.png', realisticSheet: 'assets/laminas/leo-realista-a4.pdf' },
    { id: 'luis', name: 'Luis', role: 'Melchor · el regalo del oro', image: 'assets/figuras/luis.png', sheet: 'assets/laminas/luis-a4.pdf', realisticImage: 'assets/figuras/realistas/luis.png', realisticSheet: 'assets/laminas/luis-realista-a4.pdf' },
    { id: 'ivonne', name: 'Ivonne', role: 'María · el corazón del portal', image: 'assets/figuras/ivonne.png', sheet: 'assets/laminas/ivonne-a4.pdf', realisticImage: 'assets/figuras/realistas/ivonne.png', realisticSheet: 'assets/laminas/ivonne-realista-a4.pdf' },
    { id: 'roser', name: 'Roser', role: 'Panadera · el pan para compartir', image: 'assets/figuras/roser.png', sheet: 'assets/laminas/roser-a4.pdf', realisticImage: 'assets/figuras/realistas/roser.png', realisticSheet: 'assets/laminas/roser-realista-a4.pdf' },
    { id: 'santi', name: 'Santi', role: 'Gaspar · el regalo del incienso', image: 'assets/figuras/santi.png', sheet: 'assets/laminas/santi-a4.pdf', realisticImage: 'assets/figuras/realistas/santi.png', realisticSheet: 'assets/laminas/santi-realista-a4.pdf' },
    { id: 'berta', name: 'Berta', role: 'Pastora · una cesta de buenos deseos', image: 'assets/figuras/berta.png', sheet: 'assets/laminas/berta-a4.pdf', realisticImage: 'assets/figuras/realistas/berta.png', realisticSheet: 'assets/laminas/berta-realista-a4.pdf' },
    { id: 'fran', name: 'Fran Mateos', role: 'Pastor · el calor de la leña', image: 'assets/figuras/fran.png', sheet: 'assets/laminas/fran-a4.pdf', realisticImage: 'assets/figuras/realistas/fran.png', realisticSheet: 'assets/laminas/fran-realista-a4.pdf' },
    { id: 'cristian', name: 'Cristian', role: 'José · el cuidado de los nuestros', image: 'assets/figuras/cristian.png', sheet: 'assets/laminas/cristian-a4.pdf', realisticImage: 'assets/figuras/realistas/cristian.png', realisticSheet: 'assets/laminas/cristian-realista-a4.pdf' },
    { id: 'luz', name: 'Luz', role: 'Ángel · la buena noticia', image: 'assets/figuras/luz.png', sheet: 'assets/laminas/luz-a4.pdf', realisticImage: 'assets/figuras/realistas/luz.png', realisticSheet: 'assets/laminas/luz-realista-a4.pdf' },
    { id: 'humberto', name: 'Humberto', role: 'Pastor · la luz del farol', image: 'assets/figuras/humberto.png', sheet: 'assets/laminas/humberto-a4.pdf', realisticImage: 'assets/figuras/realistas/humberto.png', realisticSheet: 'assets/laminas/humberto-realista-a4.pdf' },
    { id: 'celeste', name: 'Celeste', role: 'Pastora · la ternura del cordero', image: 'assets/figuras/celeste.png', sheet: 'assets/laminas/celeste-a4.pdf', realisticImage: 'assets/figuras/realistas/celeste.png', realisticSheet: 'assets/laminas/celeste-realista-a4.pdf' },
    { id: 'ernesto', name: 'Ernesto', role: 'Pastor · el camino del cayado', image: 'assets/figuras/ernesto.png', sheet: 'assets/laminas/ernesto-a4.pdf', realisticImage: 'assets/figuras/realistas/ernesto.png', realisticSheet: 'assets/laminas/ernesto-realista-a4.pdf' },
    { id: 'yanira', name: 'Yanira', role: 'Ángel · la estrella que nos guía', image: 'assets/figuras/yanira.png', sheet: 'assets/laminas/yanira-a4.pdf', realisticImage: 'assets/figuras/realistas/yanira.png', realisticSheet: 'assets/laminas/yanira-realista-a4.pdf' },
    { id: 'carlos', name: 'Carlos', role: 'Carpintero · manos que construyen', image: 'assets/figuras/carlos.png', sheet: 'assets/laminas/carlos-a4.pdf', realisticImage: 'assets/figuras/realistas/carlos.png', realisticSheet: 'assets/laminas/carlos-realista-a4.pdf' },
    { id: 'francis', name: 'Francis', role: 'Músico · Navidad al son del timple', image: 'assets/figuras/francis.png', sheet: 'assets/laminas/francis-a4.pdf', realisticImage: 'assets/figuras/realistas/francis.png', realisticSheet: 'assets/laminas/francis-realista-a4.pdf' },
    { id: 'rosy', name: 'Rosy', role: 'Panadera · pan para compartir', image: 'assets/figuras/rosy.png', sheet: 'assets/laminas/rosy-a4.pdf', realisticImage: 'assets/figuras/realistas/rosy.png', realisticSheet: 'assets/laminas/rosy-realista-a4.pdf' },
    { id: 'elisa', name: 'Elisa', role: 'Alfarera · el cariño toma forma', image: 'assets/figuras/elisa.png', sheet: 'assets/laminas/elisa-a4.pdf', realisticImage: 'assets/figuras/realistas/elisa.png', realisticSheet: 'assets/laminas/elisa-realista-a4.pdf' }
  ]
};
