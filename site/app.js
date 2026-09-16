/* Language choice for the landing page.
 *
 * The initial state is set by a small inline script in the <head>, so the
 * page never flashes the wrong language. This file only wires up the
 * clicks. Without JavaScript the gate is not shown and both languages are
 * rendered one after the other; nothing here is required to read the page.
 */
(function () {
  'use strict';

  var KEY = 'co2-lang';
  var root = document.documentElement;

  function choose(lang) {
    if (lang !== 'nl' && lang !== 'en') return;
    root.setAttribute('data-lang', lang);
    root.classList.add('chose');
    root.lang = lang;
    try {
      localStorage.setItem(KEY, lang);
    } catch (e) {
      /* private mode, or storage disabled: the choice just is not kept */
    }
    if (history.replaceState) {
      history.replaceState(null, '', '#' + lang);
    } else {
      location.hash = lang;
    }
    window.scrollTo(0, 0);
  }

  document.addEventListener('click', function (ev) {
    var el = ev.target.closest ? ev.target.closest('[data-lang-choice]') : null;
    if (!el) return;
    ev.preventDefault();
    choose(el.getAttribute('data-lang-choice'));
  });

  window.addEventListener('hashchange', function () {
    var h = location.hash.replace('#', '');
    if (h === 'nl' || h === 'en') choose(h);
  });
})();
