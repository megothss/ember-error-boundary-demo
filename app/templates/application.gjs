import Component from '@glimmer/component';
import { KEYWORD_DEMO_URL } from 'error-boundary-demo/variant';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import { LinkTo } from '@ember/routing';
import { VERSION } from '@ember/version';

const DEMOS = [
  { num: '1', label: 'Initial Render Error', route: 'initial-render-error' },
  { num: '2', label: 'Rerender Error', route: 'rerender-error' },
  { num: '3', label: 'Retry & Recovery', route: 'retry-recovery' },
  { num: '4', label: 'Nested Boundaries', route: 'nested-boundaries' },
  { num: '5', label: 'Sibling Isolation', route: 'sibling-isolation' },
  { num: '6', label: 'Each Loop Insert', route: 'each-loop-insert' },
  { num: '7', label: 'Controller Route', route: 'controller-error' },
  { num: '8', label: 'Layout + Outlet', route: 'outlet-layout.child' },
  { num: '9', label: 'Not Caught', route: 'not-caught' },
  { num: '10', label: 'Silent Error', route: 'silent-error' },
  { num: '11', label: 'Catch Block Throws', route: 'error-block-throws' },
  { num: '12', label: 'Sibling Update', route: 'sibling-update' },
  { num: '13', label: 'In-Element Portal', route: 'in-element-portal' },
  { num: '14', label: 'Fine-grained Retry', route: 'fine-grained-retry' },
  { num: '15', label: 'Fallback Errors', route: 'fallback-errors' },
  { num: '16', label: 'Lifecycle Cleanup', route: 'lifecycle-cleanup' },
];

class App extends Component {
  @tracked isDark =
    window.matchMedia?.('(prefers-color-scheme: dark)').matches ?? true;

  toggleTheme = () => {
    this.isDark = !this.isDark;
    document.documentElement.setAttribute(
      'data-theme',
      this.isDark ? 'dark' : 'light'
    );
  };

  <template>
    <div class="app-layout">
      <header class="app-header">
        <div class="header-left">
          <LinkTo @route="index" class="header-title-link">
            <h1>ErrorBoundary Demo</h1>
          </LinkTo>
          <span class="subtitle">ember-source {{VERSION}}</span>
        </div>
        <div class="header-right">
          <a class="header-link" href={{KEYWORD_DEMO_URL}}>Keyword version</a>
          <a
            class="header-link"
            href="https://github.com/megothss/rfcs/blob/error-boundary-rfc/text/0000-error-boundary.md"
            target="_blank"
            rel="noopener noreferrer"
          >Draft RFC</a>
          <a
            class="header-link"
            href="https://github.com/megothss/ember.js/pull/2"
            target="_blank"
            rel="noopener noreferrer"
          >Fork PR</a>
        </div>
      </header>

      <nav class="sidebar">
        <div class="sidebar-label">Scenarios</div>
        {{#each DEMOS as |demo|}}
          <LinkTo @route={{demo.route}} class="sidebar-item">
            <span class="sidebar-number">{{demo.num}}</span>
            <span class="sidebar-item-label">{{demo.label}}</span>
          </LinkTo>
        {{/each}}
        <button
          class="theme-toggle"
          type="button"
          {{on "click" this.toggleTheme}}
        >
          {{if this.isDark "☀️ Light" "🌙 Dark"}}
        </button>
      </nav>

      <main class="content-area">
        <ErrorBoundary>
          <:try>
            {{outlet}}
          </:try>
          <:catch as |err|>
            <div class="error-box">
              <strong>Route error caught!</strong>
              {{err.message}}
              <br />
              <span class="hint">Click a sidebar item to navigate away. The
                failed render read the route state, so the boundary retries when
                it changes.</span>
            </div>
          </:catch>
        </ErrorBoundary>
      </main>
    </div>
  </template>
}

export default App;
