import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { ErrorBoundary } from '@ember/component';

let catchCount = 0;

class ItemComponent extends Component {
  get value() {
    if (this.args.item === 'bomb') {
      catchCount++;
      throw new Error(`bomb item exploded! (catch #${catchCount})`);
    }
    return this.args.item;
  }

  <template>
    <span class="item">{{this.value}} </span>
  </template>
}

export default class EachInsertDemo extends Component {
  @tracked items = ['alpha', 'beta'];

  get hasBomb() {
    return this.items.includes('bomb');
  }

  get isClean() {
    return !this.hasBomb;
  }

  addBadItem = () => {
    this.items = [...this.items, 'bomb'];
  };

  reset = () => {
    this.items = ['alpha', 'beta'];
  };

  <template>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.hasBomb}}
        type="button"
        data-test-add-bad-item
        {{on "click" this.addBadItem}}
      >
        Add bad item
      </button>
      <button
        class="fix-btn"
        disabled={{this.isClean}}
        type="button"
        data-test-reset-items
        {{on "click" this.reset}}
      >
        Reset items
      </button>
    </div>

    <ErrorBoundary>
      <:try>
        {{#each this.items as |item|}}
          <ItemComponent @item={{item}} />
        {{/each}}
      </:try>
      <:catch as |err|>
        <div class="error-box">
          <strong>Caught!</strong>
          {{err.message}}
          <br />
          <span class="hint">The failed render read the items. Click "Reset
            items" and the boundary retries on its own.</span>
        </div>
      </:catch>
    </ErrorBoundary>
  </template>
}
