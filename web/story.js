// Construye los capítulos del recorrido a partir de content.js. Usa `content`, `thumb` y `showPortrait` de app.js.
const cast = Object.fromEntries(content.people.map(person => [person.id, person]));

function make(tag, className, text) {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (text) node.textContent = text;
  return node;
}

const parade = document.querySelector('#parade');
for (const person of content.people) {
  const image = make('img');
  image.src = thumb(person);
  image.alt = '';
  image.width = 720;
  image.height = 960;
  parade.append(image);
}

content.chapters.forEach((chapter, index) => {
  const members = chapter.people.map(id => cast[id] || content.extras[id]);
  const section = make('section', 'chapter');
  section.id = `capitulo-${chapter.id}`;
  section.style.cssText = `--bg:${chapter.bg};--accent:${chapter.accent};--n:${members.length}`;
  section.setAttribute('aria-labelledby', `titulo-${chapter.id}`);

  const title = make('div', 'title-card');
  title.dataset.p = 'view';
  const ghost = make('span', 'ghost', String(index + 1).padStart(2, '0'));
  ghost.setAttribute('aria-hidden', 'true');
  const heading = make('h2', '', chapter.title);
  heading.id = `titulo-${chapter.id}`;
  title.append(ghost, make('p', 'eyebrow', `Capítulo ${index + 1} de ${content.chapters.length}`), heading, make('p', 'line', chapter.line));

  const reel = make('div', 'reel');
  reel.dataset.p = 'pin';
  const stage = make('div', 'stage');
  const head = make('p', 'reel-head');
  head.append(make('span', '', chapter.title), make('span', '', `${members.length} figuras`));
  const track = make('div', 'track');

  members.forEach((person, i) => {
    const clickable = Boolean(cast[person.id]);
    const card = make(clickable ? 'button' : 'div', 'card');
    card.style.setProperty('--i', i);
    const [kind, motto] = person.role.split(' · ');
    const big = make('span', 'ghost-name', person.name.split(' ')[0]);
    big.setAttribute('aria-hidden', 'true');
    const image = make('img');
    image.src = thumb(person);
    image.alt = `${person.name}, ${kind}`;
    image.width = 720;
    image.height = 960;
    image.loading = 'lazy';
    const caption = make('span', 'cap');
    caption.append(make('small', '', kind), make('strong', '', person.name), make('em', '', motto));
    card.append(big, image, caption);
    if (clickable) {
      card.type = 'button';
      caption.append(make('i', '', 'Ver lámina ↗'));
      card.addEventListener('click', () => showPortrait(person));
      // El carrusel se mueve con el scroll: al llegar con el teclado, lleva la página hasta esa figura.
      card.addEventListener('focus', () => {
        if (!card.matches(':focus-visible')) return;
        const box = reel.getBoundingClientRect();
        scrollTo({ top: scrollY + box.top + (i / Math.max(members.length - 1, 1)) * (box.height - innerHeight) });
      });
    }
    track.append(card);
  });

  stage.append(head, track);
  reel.append(stage);
  section.append(title, reel);
  document.querySelector('#chapters').append(section);
});

// Sin scroll-driven animations (p. ej. Safari < 26): calcula aquí el mismo --p que anima el CSS.
// `?js` fuerza este camino para poder probarlo en un navegador moderno.
const nativeScroll = CSS.supports('(animation-timeline: view()) and (animation-range: entry)') && !location.search.includes('js');
if (!nativeScroll && !matchMedia('(prefers-reduced-motion: reduce)').matches) {
  document.documentElement.classList.add('js-p');
  const visible = new Set();
  const bar = document.querySelector('.progress');
  let queued = false;
  const update = () => {
    queued = false;
    const viewport = innerHeight;
    for (const node of visible) {
      const box = node.getBoundingClientRect();
      const progress = node.dataset.p === 'pin' ? -box.top / (box.height - viewport) : (viewport - box.top) / (viewport + box.height);
      node.style.setProperty('--p', Math.min(1, Math.max(0, progress)).toFixed(4));
    }
    bar.style.transform = `scaleX(${scrollY / (document.documentElement.scrollHeight - viewport)})`;
  };
  const schedule = () => { if (!queued) { queued = true; requestAnimationFrame(update); } };
  const observer = new IntersectionObserver(entries => {
    for (const entry of entries) entry.isIntersecting ? visible.add(entry.target) : visible.delete(entry.target);
    schedule();
  });
  document.querySelectorAll('[data-p]').forEach(node => observer.observe(node));
  addEventListener('scroll', schedule, { passive: true });
  addEventListener('resize', schedule);
}
