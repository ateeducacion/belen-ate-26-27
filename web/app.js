const content = window.belenContent;
const people = document.querySelector('#people');
const search = document.querySelector('#search');
const dialog = document.querySelector('#portrait');
let activePerson;
// Copia ligera (WebP) de cada figura para la página; el PNG original queda para el diálogo.
const thumb = person => person.image.replace('figuras/', 'figuras/web/').replace('.png', '.webp');
const normalize = text => text.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();

function addDownload(id, path, statusId) {
  if (!path) return;
  const link = document.getElementById(id);
  link.href = path;
  link.hidden = false;
  if (statusId) document.getElementById(statusId).hidden = true;
}

function showPortrait(person) {
  activePerson = person;
  document.querySelector('#portrait-styles').hidden = !person.realisticImage;
  setPortraitStyle(false);
  dialog.showModal();
}

function setPortraitStyle(realistic) {
  const person = activePerson;
  const sheet = realistic ? person.realisticSheet : person.sheet;
  const image = document.querySelector('#portrait-image');
  image.src = realistic ? person.realisticImage : person.image;
  image.alt = `${person.name}, ${person.role}, versión ${realistic ? 'realista' : 'figurita'}`;
  document.querySelector('#portrait-name').textContent = person.name;
  document.querySelector('#portrait-role').textContent = person.role;
  const link = document.querySelector('#portrait-download');
  link.hidden = !sheet;
  link.removeAttribute('href');
  if (sheet) link.href = sheet;
  document.querySelector('#portrait-pending').hidden = Boolean(sheet);
  document.querySelector('#style-figure').setAttribute('aria-pressed', String(!realistic));
  document.querySelector('#style-realistic').setAttribute('aria-pressed', String(realistic));
}

function render() {
  const matches = content.people.filter(person => normalize(person.name).includes(normalize(search.value.trim())));
  people.replaceChildren();
  for (const person of matches) {
    const card = document.createElement('article');
    card.className = 'person';
    const art = document.createElement('div');
    art.className = 'person-art';
    if (person.image) {
      const button = document.createElement('button');
      button.className = 'art-button';
      button.setAttribute('aria-label', `Ver lámina de ${person.name}`);
      const image = document.createElement('img');
      image.src = thumb(person);
      image.alt = `${person.name} en el belén`;
      image.loading = 'lazy';
      image.width = 480;
      image.height = 600;
      button.append(image);
      button.addEventListener('click', () => showPortrait(person));
      art.append(button);
    } else {
      const initials = document.createElement('span');
      initials.className = 'initials';
      initials.textContent = person.name.split(' ').map(word => word[0]).join('');
      initials.setAttribute('aria-hidden', 'true');
      art.append(initials);
    }
    const name = document.createElement('h3');
    name.textContent = person.name;
    const role = document.createElement('p');
    role.className = 'role';
    role.textContent = person.role;
    const action = document.createElement(person.sheet ? 'a' : 'p');
    action.className = person.sheet ? 'text-link' : 'pending';
    action.textContent = person.sheet ? 'Descargar mi lámina ↓' : 'Ilustración en preparación';
    if (person.sheet) {
      action.href = person.sheet;
      action.setAttribute('download', '');
    }
    card.append(art, name, role, action);
    if (person.realisticImage) {
      const compare = document.createElement('button');
      compare.className = 'compare-link';
      compare.textContent = 'Ver figurita / realista';
      compare.addEventListener('click', () => showPortrait(person));
      card.append(compare);
    }
    people.append(card);
  }
  document.querySelector('#result-count').textContent = matches.length ? `${matches.length} de ${content.people.length} personajes` : 'No encontramos ese nombre. Prueba con otro.';
}

addDownload('scene-download', content.scene);
addDownload('collection-download', content.collection, 'collection-status');
search.addEventListener('input', render);
dialog.querySelector('.close').addEventListener('click', () => dialog.close());
document.querySelector('#style-figure').addEventListener('click', () => setPortraitStyle(false));
document.querySelector('#style-realistic').addEventListener('click', () => setPortraitStyle(true));
render();

const lightbox = document.querySelector('#scene-lightbox');
function openScene(src, alt) {
  const enlarged = lightbox.querySelector('img');
  enlarged.src = src;
  enlarged.alt = alt;
  lightbox.showModal();
}
document.querySelector('#scene-zoom').addEventListener('click', () => openScene(content.scene, 'Belén completo con las figuritas originales'));
lightbox.querySelector('.close').addEventListener('click', () => lightbox.close());
