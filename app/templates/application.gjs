import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import { ErrorBoundary } from '@ember/component';
import { LinkTo } from '@ember/routing';

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
  { num: '11', label: 'Error Block Throws', route: 'error-block-throws' },
  { num: '12', label: 'Sibling Update', route: 'sibling-update' },
  { num: '13', label: 'In-Element Portal', route: 'in-element-portal' },
];

class App extends Component {
  @service router;
  @tracked isDark = window.matchMedia?.('(prefers-color-scheme: dark)').matches ?? true;

  toggleTheme = () => {
    this.isDark = !this.isDark;
    document.documentElement.setAttribute('data-theme', this.isDark ? 'dark' : 'light');
  };

  <template>
    <div class="app-layout">
      <header class="app-header">
        <div class="header-left">
          <h1>ErrorBoundary Demo</h1>
          <span class="subtitle">ember-source 6.12.0-alpha.1</span>
        </div>
        <div class="header-right">
          <a class="header-link" href="https://github.com/megothss/rfcs/blob/error-boundary-rfc/text/0000-error-boundary.md" target="_blank" rel="noopener noreferrer">RFC</a>
          <a class="header-link" href="https://github.com/megothss/ember.js/pull/2" target="_blank" rel="noopener noreferrer">PR</a>
          <a class="header-link" href="https://github.com/megothss/ember-error-boundary-demo" target="_blank" rel="noopener noreferrer">Source</a>
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
        <button class="theme-toggle" type="button" {{on "click" this.toggleTheme}}>
          {{if this.isDark "☀️ Light" "🌙 Dark"}}
        </button>
      </nav>

      <main class="content-area">
        <ErrorBoundary @retryWith={{this.router.currentRouteName}}>
          <:default>
            {{outlet}}
          </:default>
          <:error as |err|>
            <div class="error-box">
              <strong>Route error caught!</strong> {{err.message}}
              <br />
              <span class="hint">Click a sidebar item to navigate away and reset.</span>
            </div>
          </:error>
        </ErrorBoundary>
      </main>
    </div>
  </template>
}

export default App;
