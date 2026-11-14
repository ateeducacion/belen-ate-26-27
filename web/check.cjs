const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');

class Element {
  constructor() { this.children = []; this.hidden = false; this.value = ''; this.handlers = {}; }
  append(...children) { this.children.push(...children); }
  replaceChildren(...children) { this.children = children; }
  setAttribute(name, value) { this[name] = value; }
  removeAttribute(name) { delete this[name]; }
  addEventListener(name, handler) { this.handlers[name] = handler; }
  querySelector(selector) { return get(selector); }
  showModal() { this.open = true; }
  close() { this.open = false; }
}
const elements = new Map();
function get(selector) {
  if (!elements.has(selector)) elements.set(selector, new Element());
  return elements.get(selector);
}
const context = vm.createContext({ window: {}, document: {
  querySelector: get, getElementById: id => get(`#${id}`), createElement: () => new Element()
} });
vm.runInContext(fs.readFileSync(path.join(__dirname, 'content.js'), 'utf8'), context);
const content = context.window.belenContent;
assert.equal(content.people.length, 17);
assert.equal(new Set(content.people.map(p => p.id)).size, 17);
for (const file of [content.scene, content.collection, ...content.people.flatMap(p => [p.image, p.sheet])].filter(Boolean)) {
  assert(!file.includes('..') && file.startsWith('assets/'), `Ruta fuera de assets: ${file}`);
  assert(fs.existsSync(path.join(__dirname, file)), `Falta ${file}`);
}
vm.runInContext(fs.readFileSync(path.join(__dirname, 'app.js'), 'utf8'), context);
assert.equal(get('#people').children.length, 17);
get('#search').value = '  ivónne  ';
get('#search').handlers.input();
assert.equal(get('#people').children.length, 1);
assert.equal(get('#people').children[0].children[1].textContent, 'Ivonne');
get('#search').value = '<script>';
get('#search').handlers.input();
assert.equal(get('#people').children.length, 0);
// Ejercita los estados finales sin necesitar imágenes ni PDFs de prueba.
content.people[3].image = 'assets/example.png';
content.people[3].sheet = 'assets/example.pdf';
get('#search').value = 'Ivonne';
get('#search').handlers.input();
const card = get('#people').children[0];
assert.equal(card.children[3].href, 'assets/example.pdf');
card.children[0].children[0].handlers.click();
assert.equal(get('#portrait').open, true);
assert.equal(get('#portrait-download').href, 'assets/example.pdf');
get('.close').handlers.click();
assert.equal(get('#portrait').open, false);
assert(fs.existsSync(path.join(__dirname, 'assets/background.png')));
const html = fs.readFileSync(path.join(__dirname, 'index.html'), 'utf8');
for (const asset of ['ate-logo.png', 'ate-logo-completo.png', 'og-image.png']) {
  assert(fs.existsSync(path.join(__dirname, 'assets', asset)));
  assert(html.includes(`assets/${asset}`));
}
assert(html.includes('property="og:image"'));
assert(html.includes('name="twitter:card" content="summary_large_image"'));
console.log('OK: 17 fichas, rutas, búsqueda, estados pendientes, descarga y diálogo.');
