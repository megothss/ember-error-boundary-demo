import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import MaybeThrows from './maybe-throws';

export default class RerenderDemo extends Component {
  @tracked shouldThrow = false;

  triggerError = () => (this.shouldThrow = true);

  <template>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.shouldThrow}}
        type="button"
        {{on "click" this.triggerError}}
      >
        Trigger error
      </button>
    </div>

    <ErrorBoundary>
      <:try>
        <MaybeThrows @shouldThrow={{this.shouldThrow}} />
      </:try>
      <:catch as |err|>
        <div class="error-box">
          <strong>Caught on rerender!</strong>
          {{err.message}}
        </div>
      </:catch>
    </ErrorBoundary>
  </template>
}
