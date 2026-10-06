import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import Counter from './counter';

// A plain object, deliberately not tracked: the boundary cannot see it change.
const service = { isDown: false };

class Fragile extends Component {
  static catchCount = 0;

  get value() {
    if (this.args.shouldThrow) {
      Fragile.catchCount++;
      throw new Error(`Tracked state is broken (catch #${Fragile.catchCount})`);
    }

    // Each request re-renders this component, and reads the untracked service.
    if (this.args.requestId >= 0 && service.isDown) {
      Fragile.catchCount++;
      throw new Error(`Service unavailable (catch #${Fragile.catchCount})`);
    }

    return `Rendered OK (after ${Fragile.catchCount} catches)`;
  }

  <template>
    <div class="success">{{this.value}}</div>
  </template>
}

export default class RetryDemo extends Component {
  @tracked requestId = 0;

  /** Mirrors service.isDown for the buttons. The failed render never reads it. */
  @tracked serviceDown = false;

  @tracked shouldThrow = false;

  breakState = () => (this.shouldThrow = true);
  fixState = () => (this.shouldThrow = false);

  endOutage = () => {
    service.isDown = false;
    this.serviceDown = false;
  };

  startOutage = () => {
    service.isDown = true;
    this.serviceDown = true;
    this.requestId++;
  };

  get isServiceUp() {
    return !this.serviceDown;
  }

  get isStateOk() {
    return !this.shouldThrow;
  }

  <template>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.shouldThrow}}
        type="button"
        data-test-break-state
        {{on "click" this.breakState}}
      >
        Break tracked state
      </button>
      <button
        class="fix-btn"
        disabled={{this.isStateOk}}
        type="button"
        data-test-fix-state
        {{on "click" this.fixState}}
      >
        Fix state
      </button>
    </div>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.serviceDown}}
        type="button"
        data-test-start-outage
        {{on "click" this.startOutage}}
      >
        Simulate outage
      </button>
      <button
        class="fix-btn"
        disabled={{this.isServiceUp}}
        type="button"
        data-test-end-outage
        {{on "click" this.endOutage}}
      >
        End outage
      </button>
    </div>

    <ErrorBoundary>
      <:try>
        <Fragile
          @shouldThrow={{this.shouldThrow}}
          @requestId={{this.requestId}}
        />
        <Counter />
      </:try>
      <:catch as |err retry|>
        <div class="error-box">
          <strong>Caught!</strong>
          {{err.message}}
          <br />
          {{#if this.shouldThrow}}
            <span class="hint status-bad">The render read shouldThrow before it
              threw. Click "Fix state" and the boundary retries on its own.</span>
          {{else if this.serviceDown}}
            <span class="hint status-bad">The outage lives in untracked state.
              Retry will re-catch until it ends.</span>
          {{else}}
            <span class="hint status-ok">The outage is over, but the boundary
              can't know: that state isn't tracked. Click Retry.</span>
          {{/if}}
          <br />
          <button
            class="retry-btn"
            type="button"
            data-test-retry
            {{on "click" retry}}
          >Retry</button>
        </div>
      </:catch>
    </ErrorBoundary>
  </template>
}
