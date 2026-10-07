import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Counter from './counter';

export default class SiblingUpdateDemo extends Component {
  @tracked label = 'Hello from sibling';

  changeLabel = () => {
    this.label =
      this.label === 'Hello from sibling'
        ? 'Updated sibling!'
        : 'Hello from sibling';
  };

  <template>
    <p class="hint">
      A try block followed by sibling content with tracked state. Clicking
      the button triggers a tracked update on the sibling — without the
      block-stack fix this crashes with
      <code>Cannot read properties of null (reading 'nextSibling')</code>.
    </p>

    {{#try}}
      <div class="success">Try block content, no error here.</div>
    {{catch as |err|}}
      <div class="error-box">
        <strong>Caught!</strong>
        {{err.message}}
      </div>
    {{/try}}

    <div class="sibling-after">
      <h4>Sibling after the try block</h4>
      <p>{{this.label}}</p>
      <div class="controls">
        <button class="fix-btn" type="button" {{on "click" this.changeLabel}}>
          Toggle label
        </button>
      </div>
      <Counter />
    </div>
  </template>
}
