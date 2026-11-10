// Arranca reveal.js
Reveal.initialize({
  hash: true,          // la URL recuerda en qué diapositiva estás
  slideNumber: 'c/t',  // número de diapositiva abajo a la derecha
  transition: 'slide',
  width: 1280,
  height: 720,
});

// Si una gráfica aún no está exportada, en su sitio aparece un hueco con el nombre del archivo
function ponHueco(img) {
  const hueco = document.createElement('div');
  hueco.className = 'hueco';
  hueco.textContent = 'Falta exportar: ' + img.getAttribute('src');
  img.replaceWith(hueco);
}
document.querySelectorAll('img.grafica').forEach((img) => {
  if (img.complete && img.naturalWidth === 0) {
    ponHueco(img);                                   // ya falló antes de que llegara este script
  } else {
    img.addEventListener('error', () => ponHueco(img));
  }
});

// El minifurrito cruza la pantalla al llegar a una diapositiva que empieza bloque (data-bloque)
function cruzaElFurrito() {
  const furrito = document.getElementById('furrito');
  gsap.killTweensOf(furrito);
  gsap.fromTo(furrito,
    { x: 0, y: 0 },
    {
      x: window.innerWidth + 320,
      duration: 1.6,
      ease: 'power1.inOut',
      // pequeños saltitos mientras corre
      onUpdate() {
        const avance = this.progress();
        gsap.set(furrito, { y: -Math.abs(Math.sin(avance * Math.PI * 6)) * 14 });
      },
    }
  );
}

// Los contadores (class="contador") van del valor data-desde al data-hasta
function animaContadores(diapositiva) {
  diapositiva.querySelectorAll('.contador').forEach((el) => {
    const datos = { valor: Number(el.dataset.desde) };
    gsap.to(datos, {
      valor: Number(el.dataset.hasta),
      duration: 1.5,
      ease: 'power2.out',
      onUpdate: () => { el.textContent = Math.round(datos.valor); },
    });
  });
}

Reveal.on('slidechanged', (evento) => {
  const diapositiva = evento.currentSlide;
  if (diapositiva.dataset.bloque && diapositiva.dataset.bloque !== 'portada') {
    cruzaElFurrito();
  }
  animaContadores(diapositiva);
});
