import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';
import Counter from './counter';

export default class SiblingUpdateDemo extends Component {
  @tracked label = 'Hello from sibling';

  changeLabel = () => {
    this.label = this.label === 'Hello from sibling' ? 'Updated sibling!' : 'Hello from sibling';
  };

  <template>
    <p class="hint">
      An ErrorBoundary followed by sibling content with tracked state.
      Clicking the button triggers a tracked update on the sibling — without the
      block-stack fix this crashes with <code>Cannot read properties of null (reading 'nextSibling')</code>.
    </p>

    <ErrorBoundary>
      <:default>
        <div class="success">ErrorBoundary content — no error here.</div>
      </:default>
      <:error as |err|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}}
        </div>
      </:error>
    </ErrorBoundary>

    <div class="sibling-after" style="margin-top: 1rem;">
      <h4>Sibling after ErrorBoundary</h4>
      <p>{{this.label}}</p>
      <div class="controls">
        <button class="fix-btn" {{on "click" this.changeLabel}}>
          Toggle label
        </button>
      </div>
      <Counter />
    </div>
  </template>
}
