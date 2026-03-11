import { modifier } from 'ember-modifier';
import hljs from 'highlight.js/lib/core';
import xml from 'highlight.js/lib/languages/xml';
import javascript from 'highlight.js/lib/languages/javascript';
import handlebars from 'highlight.js/lib/languages/handlebars';
import darkTheme from 'highlight.js/styles/atom-one-dark.css?raw';
import lightTheme from 'highlight.js/styles/atom-one-light.css?raw';

hljs.registerLanguage('xml', xml);
hljs.registerLanguage('javascript', javascript);
hljs.registerLanguage('handlebars', handlebars);

let styleEl;

function syncTheme() {
  if (!styleEl) {
    styleEl = document.createElement('style');
    styleEl.id = 'hljs-theme';
    document.head.appendChild(styleEl);
  }
  const isDark =
    document.documentElement.getAttribute('data-theme') === 'dark' ||
    (!document.documentElement.hasAttribute('data-theme') &&
      window.matchMedia('(prefers-color-scheme: dark)').matches);
  styleEl.textContent = isDark ? darkTheme : lightTheme;
}

const observer = new MutationObserver(syncTheme);
observer.observe(document.documentElement, {
  attributes: true,
  attributeFilter: ['data-theme'],
});
syncTheme();

export default modifier((element, [language]) => {
  if (language) {
    element.className = `language-${language}`;
  }
  hljs.highlightElement(element);
});
