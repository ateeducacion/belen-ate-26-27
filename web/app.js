const content = window.belenContent;
const people = document.querySelector('#people');
const search = document.querySelector('#search');
const dialog = document.querySelector('#portrait');
const normalize = text => text.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();

function addDownload(id, path, statusId) {
  if (!path) return;
  const link = document.getElementById(id);
  link.href = path;
  link.hidden = false;
  if (statusId) document.getElementById(statusId).hidden = true;
}

function showPortrait(person) {
  const image = document.querySelector('#portrait-image');
  image.src = person.image;
  image.alt = `${person.name}, ${person.role}`;
  document.querySelector('#portrait-name').textContent = person.name;
  document.querySelector('#portrait-role').textContent = person.role;
  const link = document.querySelector('#portrait-download');
  link.hidden = !person.sheet;
  link.removeAttribute('href');
  if (person.sheet) link.href = person.sheet;
  document.querySelector('#portrait-pending').hidden = Boolean(person.sheet);
  dialog.showModal();
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
      image.src = person.image;
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
    people.append(card);
  }
  document.querySelector('#result-count').textContent = matches.length ? `${matches.length} de ${content.people.length} personajes` : 'No encontramos ese nombre. Prueba con otro.';
}

if (content.scene) {
  const image = document.createElement('img');
  image.src = content.scene;
  image.alt = 'Belén completo con los diecisiete compañeros de ATE y el Niño Jesús';
  image.width = 1920;
  image.height = 1080;
  document.querySelector('#scene').replaceChildren(image);
  document.querySelector('#scene-note').textContent = 'Nuestro belén, al completo';
}
addDownload('scene-download', content.scene);
addDownload('collection-download', content.collection, 'collection-status');
search.addEventListener('input', render);
dialog.querySelector('.close').addEventListener('click', () => dialog.close());
render();
