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

// Cuadros de texto (class="cuadro-info") que aparecen a los data-retraso segundos
function muestraCuadros(diapositiva) {
  diapositiva.querySelectorAll('.cuadro-info').forEach((cuadro) => {
    gsap.killTweensOf(cuadro);
    gsap.fromTo(cuadro,
      { opacity: 0, y: 30 },
      { opacity: 1, y: 0, duration: 0.8, ease: 'power2.out',
        delay: Number(cuadro.dataset.retraso || 20) });
  });
}

// Al salir de la diapositiva se esconden, para que vuelvan a salir si regresas
function escondeCuadros(diapositiva) {
  if (!diapositiva) return;
  diapositiva.querySelectorAll('.cuadro-info').forEach((cuadro) => {
    gsap.killTweensOf(cuadro);
    gsap.set(cuadro, { opacity: 0 });
  });
}

Reveal.on('slidechanged', (evento) => {
  const diapositiva = evento.currentSlide;
  if (diapositiva.dataset.bloque && diapositiva.dataset.bloque !== 'portada') {
    cruzaElFurrito();
  }
  animaContadores(diapositiva);
  escondeCuadros(evento.previousSlide);
  muestraCuadros(diapositiva);
});

// Si recargas (F5) estando ya en una diapositiva, slidechanged no salta: esto lo cubre
Reveal.on('ready', (evento) => muestraCuadros(evento.currentSlide));
