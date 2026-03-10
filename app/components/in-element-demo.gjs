import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import AlwaysThrows from './always-throws';
import MaybeThrows from './maybe-throws';

export default class InElementDemo extends Component {
  @tracked shouldThrowDefault = false;
  @tracked shouldThrowAppend = false;

  triggerDefaultError = () => (this.shouldThrowDefault = true);
  triggerAppendError = () => (this.shouldThrowAppend = true);

  resetDefaultAndRetry = (retry) => {
    this.shouldThrowDefault = false;
    retry();
  };

  resetAppendAndRetry = (retry) => {
    this.shouldThrowAppend = false;
    retry();
  };

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
        Without <code>insertBefore=null</code>, in-element replaces the portal's children.
        Notice the "Existing content" disappears once content renders.
      </p>

      <h4 class="sub">Initial render error</h4>
      <div class="in-element-layout">
        <div id="portal-default-1" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:default>
              {{#in-element this.defaultTarget1}}
                <AlwaysThrows />
              {{/in-element}}
            </:default>
            <:error as |err|>
              <div class="error-box">
                <strong>Caught!</strong> {{err.message}}
              </div>
            </:error>
          </ErrorBoundary>
        </div>
      </div>

      <h4 class="sub">Rerender error</h4>
      <div class="controls">
        <button class="trigger-btn" disabled={{this.shouldThrowDefault}} {{on "click" this.triggerDefaultError}}>
          Trigger error
        </button>
      </div>
      <div class="in-element-layout">
        <div id="portal-default-2" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:default>
              {{#in-element this.defaultTarget2}}
                <MaybeThrows @shouldThrow={{this.shouldThrowDefault}} @successMessage="This content was portaled here via in-element" />
              {{/in-element}}
            </:default>
            <:error as |err retry|>
              <div class="error-box">
                <strong>Caught!</strong> {{err.message}}
                <div class="controls" style="margin-top: 0.5rem">
                  <button class="retry-btn" {{on "click" (fn this.resetDefaultAndRetry retry)}}>
                    Reset &amp; Retry
                  </button>
                </div>
              </div>
            </:error>
          </ErrorBoundary>
        </div>
      </div>
    </div>

    <div class="in-element-section">
      <h4>Append mode (<code>insertBefore=null</code>)</h4>
      <p class="hint">
        With <code>insertBefore=null</code>, content appends alongside existing children.
        Notice the "Existing content" is preserved even after render.
      </p>

      <h4 class="sub">Initial render error</h4>
      <div class="in-element-layout">
        <div id="portal-append-1" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:default>
              {{#in-element this.appendTarget1 insertBefore=null}}
                <AlwaysThrows />
              {{/in-element}}
            </:default>
            <:error as |err|>
              <div class="error-box">
                <strong>Caught!</strong> {{err.message}}
              </div>
            </:error>
          </ErrorBoundary>
        </div>
      </div>

      <h4 class="sub">Rerender error</h4>
      <div class="controls">
        <button class="trigger-btn" disabled={{this.shouldThrowAppend}} {{on "click" this.triggerAppendError}}>
          Trigger error
        </button>
      </div>
      <div class="in-element-layout">
        <div id="portal-append-2" class="in-element-target">
          <span class="label">Remote portal</span>
          <div class="existing-content">Pre-existing content that was already in the portal before in-element rendered into it.</div>
        </div>
        <div class="in-element-source">
          <span class="label">Boundary (source)</span>
          <ErrorBoundary>
            <:default>
              {{#in-element this.appendTarget2 insertBefore=null}}
                <MaybeThrows @shouldThrow={{this.shouldThrowAppend}} @successMessage="This content was portaled here via in-element" />
              {{/in-element}}
            </:default>
            <:error as |err retry|>
              <div class="error-box">
                <strong>Caught!</strong> {{err.message}}
                <div class="controls" style="margin-top: 0.5rem">
                  <button class="retry-btn" {{on "click" (fn this.resetAppendAndRetry retry)}}>
                    Reset &amp; Retry
                  </button>
                </div>
              </div>
            </:error>
          </ErrorBoundary>
        </div>
      </div>
    </div>
  </template>
}
