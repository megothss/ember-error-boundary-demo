import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { helper } from '@ember/component/helper';
import { service } from '@ember/service';
import { ErrorBoundary } from '@ember/component';
import AlwaysThrows from 'error-boundary-demo/components/always-throws';
import Counter from 'error-boundary-demo/components/counter';
import DemoSection from 'error-boundary-demo/components/demo-section';
import EachInsertDemo from 'error-boundary-demo/components/each-insert-demo';
import NotCaughtDemo from 'error-boundary-demo/components/not-caught-demo';
import RerenderDemo from 'error-boundary-demo/components/rerender-demo';
import RetryDemo from 'error-boundary-demo/components/retry-demo';

const explodingHelper = helper(() => {
  throw new Error('Helper exploded!');
});

const DEMOS = [
  { id: 0, num: '1', label: 'Initial Render Error' },
  { id: 1, num: '2', label: 'Rerender Error' },
  { id: 2, num: '3', label: 'Retry & Recovery' },
  { id: 3, num: '4', label: 'Nested Boundaries' },
  { id: 4, num: '5', label: 'Sibling Isolation' },
  { id: 5, num: '6', label: 'Each Loop Insert' },
  { id: 6, num: '7', label: 'Controller Route', route: 'controller-error' },
  { id: 7, num: '8', label: 'Layout + Outlet', route: 'outlet-layout.child' },
  { id: 8, num: '9', label: 'Not Caught' },
];

class App extends Component {
  @service router;
  @tracked selectedDemo = 0;
  @tracked isDark = window.matchMedia?.('(prefers-color-scheme: dark)').matches ?? true;

  get isOnRoute() {
    let name = this.router.currentRouteName;
    return name && name !== 'index' && name !== 'application';
  }

  get activeRouteDemo() {
    let name = this.router.currentRouteName;
    if (name === 'controller-error') return 6;
    if (name === 'outlet-layout.child' || name === 'outlet-layout.index' || name === 'outlet-layout') return 7;
    return null;
  }

  selectDemo = (id) => {
    if (DEMOS[id].route) {
      this.router.transitionTo(DEMOS[id].route);
    } else {
      if (this.isOnRoute) {
        this.router.transitionTo('index');
      }
      this.selectedDemo = id;
    }
  };

  toggleTheme = () => {
    this.isDark = !this.isDark;
    document.documentElement.setAttribute('data-theme', this.isDark ? 'dark' : 'light');
  };

  isActive = (id) => {
    if (this.isOnRoute) {
      return this.activeRouteDemo === id;
    }
    return this.selectedDemo === id;
  };

  <template>
    <div class="app-layout">
      <header class="app-header">
        <div class="header-left">
          <h1>ErrorBoundary Demo</h1>
          <span class="subtitle">ember-source 6.12.0-alpha.1</span>
        </div>
        <button class="theme-toggle" type="button" {{on "click" this.toggleTheme}}>
          {{if this.isDark "Light" "Dark"}}
        </button>
      </header>

      <nav class="sidebar">
        <div class="sidebar-label">Scenarios</div>
        {{#each DEMOS as |demo|}}
          <button
            type="button"
            class="sidebar-item {{if (this.isActive demo.id) 'active'}}"
            {{on "click" (fn this.selectDemo demo.id)}}
          >
            <span class="sidebar-number">{{demo.num}}</span>
            <span class="sidebar-item-label">{{demo.label}}</span>
          </button>
        {{/each}}
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

        {{#unless this.isOnRoute}}
        {{#if (this.isActive 0)}}
          <DemoSection
            @title="1. Initial Render Error"
            @description="A component and a helper that always throw during render. The boundary catches both immediately."
          >
            <h4>Component error</h4>
            <ErrorBoundary>
              <:default>
                <AlwaysThrows />
              </:default>
              <:error as |err|>
                <div class="error-box">
                  <strong>Caught!</strong> {{err.message}}
                </div>
              </:error>
            </ErrorBoundary>

            <h4>Helper error</h4>
            <ErrorBoundary>
              <:default>
                <span>Result: {{(explodingHelper)}}</span>
              </:default>
              <:error as |err|>
                <div class="error-box">
                  <strong>Caught!</strong> {{err.message}}
                </div>
              </:error>
            </ErrorBoundary>
          </DemoSection>
        {{else if (this.isActive 1)}}
          <DemoSection
            @title="2. Rerender Error"
            @description="Renders fine initially. Click the button to flip tracked state, causing a throw on rerender."
          >
            <RerenderDemo />
          </DemoSection>
        {{else if (this.isActive 2)}}
          <DemoSection
            @title="3. Retry & Recovery"
            @description="Trigger an error, fix the state, then click Retry to recover. Repeat the cycle multiple times — the boundary never gets stuck. The counter proves interactivity survives recovery."
          >
            <RetryDemo />
          </DemoSection>
        {{else if (this.isActive 3)}}
          <DemoSection
            @title="4. Nested Boundaries"
            @description="Three levels deep. Only the innermost boundary catches the error. Middle and outer boundaries remain unaffected."
          >
            <ErrorBoundary>
              <:default>
                <div class="nested-level" data-level="1">
                  <span class="success">Level 1 — Outer boundary content is fine</span>
                  <ErrorBoundary>
                    <:default>
                      <div class="nested-level" data-level="2">
                        <span class="success">Level 2 — Middle boundary content is fine</span>
                        <ErrorBoundary>
                          <:default>
                            <div class="nested-level" data-level="3">
                              <AlwaysThrows />
                            </div>
                          </:default>
                          <:error as |err|>
                            <div class="error-box inner">
                              <strong>Level 3 caught!</strong> {{err.message}}
                            </div>
                          </:error>
                        </ErrorBoundary>
                      </div>
                    </:default>
                    <:error as |err|>
                      <div class="error-box">
                        Level 2 caught (should NOT see this): {{err.message}}
                      </div>
                    </:error>
                  </ErrorBoundary>
                </div>
              </:default>
              <:error as |err|>
                <div class="error-box">
                  Level 1 caught (should NOT see this): {{err.message}}
                </div>
              </:error>
            </ErrorBoundary>
          </DemoSection>
        {{else if (this.isActive 4)}}
          <DemoSection
            @title="5. Sibling Isolation"
            @description="Two sibling boundaries — one errors, the other keeps working independently."
          >
            <div class="siblings">
              <div class="sibling">
                <h3>Boundary A (errors)</h3>
                <ErrorBoundary>
                  <:default>
                    <AlwaysThrows />
                  </:default>
                  <:error as |err|>
                    <div class="error-box">
                      <strong>A caught!</strong> {{err.message}}
                    </div>
                  </:error>
                </ErrorBoundary>
              </div>
              <div class="sibling">
                <h3>Boundary B (works fine)</h3>
                <ErrorBoundary>
                  <:default>
                    <div class="success">
                      No errors here! <Counter />
                    </div>
                  </:default>
                  <:error as |err|>
                    <div class="error-box">
                      B caught: {{err.message}}
                    </div>
                  </:error>
                </ErrorBoundary>
              </div>
            </div>
          </DemoSection>
        {{else if (this.isActive 5)}}
          <DemoSection
            @title="6. Each Loop Insert Error"
            @description="An each loop inside an ErrorBoundary. Click to add a bad item that throws during render."
          >
            <EachInsertDemo />
          </DemoSection>
        {{else if (this.isActive 6)}}
          <DemoSection
            @title="7. Controller Error via Route"
            @description="A route with a controller whose tracked getter throws during rerender. The ErrorBoundary wraps the outlet with @retryWith bound to the current route name."
          >
            <p class="hint">Click the sidebar item to navigate. The route content will appear here, wrapped in an ErrorBoundary with @retryWith.</p>
          </DemoSection>
        {{else if (this.isActive 7)}}
          <DemoSection
            @title="8. Layout Component Wrapping Outlet"
            @description="A layout component wraps its own outlet in an ErrorBoundary. The child route always throws, but the layout stays intact."
          >
            <p class="hint">Click the sidebar item to navigate. The inner boundary catches before the outer one.</p>
          </DemoSection>
        {{else if (this.isActive 8)}}
          <DemoSection
            @title="9. Not Caught by ErrorBoundary"
            @description="ErrorBoundary only catches synchronous errors during render. Modifier install errors and async errors (setTimeout, Promises) escape the boundary."
          >
            <NotCaughtDemo />
          </DemoSection>
        {{/if}}
        {{/unless}}
      </main>
    </div>
  </template>
}

export default App;
