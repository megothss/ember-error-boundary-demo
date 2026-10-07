import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import AlwaysThrows from './always-throws';

class InnerFallback extends Component {
  get message() {
    if (this.args.broken) {
      throw new Error('The inner fallback broke while it was showing.');
    }
    return this.args.error.message;
  }

  <template>
    <div class="error-box" data-test-inner-fallback>
      <strong>Inner boundary caught:</strong>
      {{this.message}}
    </div>
  </template>
}

export default class FallbackErrorsDemo extends Component {
  @tracked fallbackBroken = false;

  breakFallback = () => (this.fallbackBroken = true);

  // The outer boundary's failed render read this flag, so repairing it is
  // enough for the outer boundary to retry on its own.
  repairFallback = () => (this.fallbackBroken = false);

  <template>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.fallbackBroken}}
        type="button"
        data-test-break-fallback
        {{on "click" this.breakFallback}}
      >
        Break the inner fallback
      </button>
      <button
        class="fix-btn"
        disabled={{if this.fallbackBroken false true}}
        type="button"
        data-test-repair-fallback
        {{on "click" this.repairFallback}}
      >
        Repair it
      </button>
    </div>

    <div class="nested-level">
      <span class="hint">Outer boundary</span>
      <ErrorBoundary>
        <:try>
          <div class="nested-level">
            <span class="hint">Inner boundary (its content always throws)</span>
            <ErrorBoundary>
              <:try>
                <AlwaysThrows />
              </:try>
              <:catch as |err|>
                <InnerFallback @error={{err}} @broken={{this.fallbackBroken}} />
              </:catch>
            </ErrorBoundary>
          </div>
        </:try>
        <:catch as |err|>
          <div class="error-box" data-test-outer-fallback>
            <strong>Outer boundary caught:</strong>
            {{err.message}}
            <br />
            <span class="hint">The inner boundary did not catch its own
              fallback's error: a boundary showing its fallback passes errors
              outward. Repair the fallback and the outer boundary retries.</span>
          </div>
        </:catch>
      </ErrorBoundary>
    </div>
  </template>
}
