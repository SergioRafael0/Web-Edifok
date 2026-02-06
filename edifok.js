/**
 * Edifok - Scripts de la web corporativa
 * Navegación suave, menú móvil, animaciones al scroll, botón scroll-top
 */
(function() {
  'use strict';

  function ready(fn) {
    if (document.readyState !== 'loading') fn();
    else document.addEventListener('DOMContentLoaded', fn);
  }

  ready(function() {
    var header = document.getElementById('header');
    var openMenu = document.getElementById('openmenu');
    var closeMenu = document.getElementById('closemenu');
    var nav = document.getElementById('navigation');
    var scrollTopBtn = document.getElementById('scroll-top');
    var menuLinks = document.querySelectorAll('.menu a[href^="#"]');

    // Scroll suave para anclas
    menuLinks.forEach(function(link) {
      link.addEventListener('click', function(e) {
        var href = this.getAttribute('href');
        if (href === '#') return;
        var target = document.querySelector(href);
        if (target) {
          e.preventDefault();
          target.scrollIntoView({ behavior: 'smooth', block: 'start' });
          if (nav.classList.contains('open')) {
            nav.classList.remove('open');
          }
        }
      });
    });

    // Menú móvil: abrir/cerrar
    if (openMenu) {
      openMenu.addEventListener('click', function(e) {
        e.preventDefault();
        if (nav) nav.classList.add('open');
      });
    }
    if (closeMenu) {
      closeMenu.addEventListener('click', function(e) {
        e.preventDefault();
        if (nav) nav.classList.remove('open');
      });
    }

    // Header con fondo al hacer scroll
    function updateHeader() {
      if (window.scrollY > 60) {
        if (header) header.classList.add('scrolled');
      } else {
        if (header) header.classList.remove('scrolled');
      }
    }
    window.addEventListener('scroll', updateHeader);
    updateHeader();

    // Botón scroll to top: mostrar/ocultar
    function updateScrollTop() {
      if (scrollTopBtn) {
        if (window.scrollY > 400) scrollTopBtn.classList.add('visible');
        else scrollTopBtn.classList.remove('visible');
      }
    }
    window.addEventListener('scroll', updateScrollTop);
    updateScrollTop();

    if (scrollTopBtn) {
      scrollTopBtn.addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });
    }

    // Animación de aparición del equipo al hacer scroll
    var teamCards = document.querySelectorAll('.team-card[data-animate]');
    var observerOptions = { root: null, rootMargin: '0px 0px -80px 0px', threshold: 0.1 };

    if (typeof IntersectionObserver !== 'undefined') {
      var observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('animate-in');
            observer.unobserve(entry.target);
          }
        });
      }, observerOptions);

      teamCards.forEach(function(card) {
        observer.observe(card);
      });
    } else {
      teamCards.forEach(function(card) {
        card.classList.add('animate-in');
      });
    }

    // Animación del contador de años al hacer scroll
    var counters = document.querySelectorAll('.counter');
    
    if (typeof IntersectionObserver !== 'undefined') {
      var counterObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            var counter = entry.target;
            var targetValue = parseInt(counter.textContent, 10);
            var duration = 2000; // 2 segundos
            var startTime = Date.now();
            var startValue = 0;

            function updateCounter() {
              var elapsed = Date.now() - startTime;
              var progress = Math.min(elapsed / duration, 1);
              var currentValue = Math.floor(startValue + (targetValue - startValue) * progress);
              counter.textContent = currentValue;

              if (progress < 1) {
                requestAnimationFrame(updateCounter);
              }
            }

            updateCounter();
            counterObserver.unobserve(counter);
          }
        });
      }, { root: null, rootMargin: '0px 0px -100px 0px', threshold: 0.1 });

      counters.forEach(function(counter) {
        counterObserver.observe(counter);
      });
    }
  });
})();
