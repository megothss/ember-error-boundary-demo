import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import Counter from './counter';

class Fragile extends Component {
  static catchCount = 0;

  get value() {
    if (this.args.shouldThrow) {
      Fragile.catchCount++;
      throw new Error(`Render error (catch #${Fragile.catchCount})`);
    }
    return `Rendered OK (after ${Fragile.catchCount} catches)`;
  }

  <template><div class="success">{{this.value}}</div></template>
}

export default class RetryDemo extends Component {
  @tracked shouldThrow = false;

  get isOk() {
    return !this.shouldThrow;
  }

  triggerError = () => (this.shouldThrow = true);
  fixState = () => (this.shouldThrow = false);

  <template>
    <div class="controls">
      <button class="trigger-btn" disabled={{this.shouldThrow}} {{on "click" this.triggerError}}>
        Trigger error
      </button>
      <button class="fix-btn" disabled={{this.isOk}} {{on "click" this.fixState}}>
        Fix state
      </button>
    </div>

    <ErrorBoundary>
      <:default>
        <Fragile @shouldThrow={{this.shouldThrow}} />
        <Counter />
      </:default>
      <:error as |err retry|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}}
          <br />
          {{#if this.shouldThrow}}
            <span class="hint status-bad">shouldThrow is still true — Retry will re-catch. Click "Fix state" first.</span>
          {{else}}
            <span class="hint status-ok">shouldThrow is false — Retry will recover.</span>
          {{/if}}
          <br />
          <button class="retry-btn" {{on "click" retry}}>Retry</button>
        </div>
      </:error>
    </ErrorBoundary>
  </template>
}
