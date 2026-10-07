import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import AlwaysThrows from './always-throws';
import MaybeThrows from './maybe-throws';

export default class InElementDemo extends Component {
  @tracked shouldThrowDefault = false;
  @tracked shouldThrowAppend = false;
  @tracked shouldThrowShared = false;

  triggerDefaultError = () => (this.shouldThrowDefault = true);
  triggerAppendError = () => (this.shouldThrowAppend = true);

  // Resetting is enough: the failed render read this state, so the boundary
  // retries on its own when it changes.
  resetDefault = () => (this.shouldThrowDefault = false);
  resetAppend = () => (this.shouldThrowAppend = false);

  triggerSharedError = () => (this.shouldThrowShared = true);
  resetShared = () => (this.shouldThrowShared = false);

  get sharedTarget() {
    return document.getElementById('portal-shared');
  }

  get defaultTarget1() {
    return document.getElementById('portal-default-1');
  }

  get defaultTarget2() {
    return document.getElementById('portal-default-2');
  }

  get appendTarget1() {
    return document.getElementById('portal-append-1');
  }

  get appendTarget2() {
    return document.getElementById('portal-append-2');
  }

  <template>
    <div class="in-element-section">
      <h4>Default mode (replaces children)</h4>
      <p class="hint">
        Without
        <code>insertBefore=null</code>, in-element replaces the portal's
        children. Notice the "Existing content" disappears once content renders.
      </p>

      <h4 class="sub">Initial render error</h4>
      <div class="in-element-layout">
        <div id="portal-default-1" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in
            the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:try>
              {{#in-element this.defaultTarget1}}
                <AlwaysThrows />
              {{/in-element}}
            </:try>
            <:catch as |err|>
              <div class="error-box">
                <strong>Caught!</strong>
                {{err.message}}
              </div>
            </:catch>
          </ErrorBoundary>
        </div>
      </div>

      <h4 class="sub">Rerender error</h4>
      <div class="controls">
        <button
          class="trigger-btn"
          disabled={{this.shouldThrowDefault}}
          type="button"
          data-test-trigger-default
          {{on "click" this.triggerDefaultError}}
        >
          Trigger error
        </button>
      </div>
      <div class="in-element-layout">
        <div id="portal-default-2" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in
            the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:try>
              {{#in-element this.defaultTarget2}}
                <MaybeThrows
                  @shouldThrow={{this.shouldThrowDefault}}
                  @successMessage="This content was portaled here via in-element"
                />
              {{/in-element}}
            </:try>
            <:catch as |err|>
              <div class="error-box">
                <strong>Caught!</strong>
                {{err.message}}
                <div class="controls controls-spaced">
                  <button
                    class="retry-btn"
                    type="button"
                    data-test-reset-default
                    {{on "click" this.resetDefault}}
                  >
                    Reset
                  </button>
                </div>
              </div>
            </:catch>
          </ErrorBoundary>
        </div>
      </div>
    </div>

    <div class="in-element-section">
      <h4>Append mode (<code>insertBefore=null</code>)</h4>
      <p class="hint">
        With
        <code>insertBefore=null</code>, content appends alongside existing
        children. Notice the "Existing content" is preserved even after render.
      </p>

      <h4 class="sub">Initial render error</h4>
      <div class="in-element-layout">
        <div id="portal-append-1" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in
            the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:try>
              {{#in-element this.appendTarget1 insertBefore=null}}
                <AlwaysThrows />
              {{/in-element}}
            </:try>
            <:catch as |err|>
              <div class="error-box">
                <strong>Caught!</strong>
                {{err.message}}
              </div>
            </:catch>
          </ErrorBoundary>
        </div>
      </div>

      <h4 class="sub">Rerender error</h4>
      <div class="controls">
        <button
          class="trigger-btn"
          disabled={{this.shouldThrowAppend}}
          type="button"
          {{on "click" this.triggerAppendError}}
        >
          Trigger error
        </button>
      </div>
      <div class="in-element-layout">
        <div id="portal-append-2" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in
            the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:try>
              {{#in-element this.appendTarget2 insertBefore=null}}
                <MaybeThrows
                  @shouldThrow={{this.shouldThrowAppend}}
                  @successMessage="This content was portaled here via in-element"
                />
              {{/in-element}}
            </:try>
            <:catch as |err|>
              <div class="error-box">
                <strong>Caught!</strong>
                {{err.message}}
                <div class="controls controls-spaced">
                  <button
                    class="retry-btn"
                    type="button"
                    data-test-reset-append
                    {{on "click" this.resetAppend}}
                  >
                    Reset
                  </button>
                </div>
              </div>
            </:catch>
          </ErrorBoundary>
        </div>
      </div>
    </div>

    <div class="in-element-section">
      <h4>Fallback in the same portal</h4>
      <p class="hint">
        Here the catch block also renders into the portal. The failed attempt's
        portal content is removed before the fallback renders, so the portal
        shows the pre-existing content and the fallback, never a mix of both.
      </p>
      <div class="controls">
        <button
          class="trigger-btn"
          disabled={{this.shouldThrowShared}}
          type="button"
          data-test-trigger-shared
          {{on "click" this.triggerSharedError}}
        >
          Trigger error
        </button>
        <button
          class="fix-btn"
          disabled={{if this.shouldThrowShared false true}}
          type="button"
          data-test-reset-shared
          {{on "click" this.resetShared}}
        >
          Reset
        </button>
      </div>
      <div class="in-element-layout">
        <div
          id="portal-shared"
          class="in-element-target"
          data-test-portal-shared
        >
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in
            the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:try>
              {{#in-element this.sharedTarget insertBefore=null}}
                <div class="success" data-test-shared-body>Body content in the
                  portal</div>
                <MaybeThrows
                  @shouldThrow={{this.shouldThrowShared}}
                  @successMessage="The body rendered into the portal"
                />
              {{/in-element}}
            </:try>
            <:catch as |err|>
              {{#in-element this.sharedTarget insertBefore=null}}
                <div class="error-box" data-test-shared-fallback>
                  <strong>Fallback in the portal:</strong>
                  {{err.message}}
                </div>
              {{/in-element}}
              <span class="hint">The fallback is in the portal.</span>
            </:catch>
          </ErrorBoundary>
        </div>
      </div>
    </div>
  </template>
}
