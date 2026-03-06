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

  <template><span class="item">{{this.value}} </span></template>
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
      <button class="trigger-btn" disabled={{this.hasBomb}} {{on "click" this.addBadItem}}>
        Add bad item
      </button>
      <button class="fix-btn" disabled={{this.isClean}} {{on "click" this.reset}}>
        Reset items
      </button>
    </div>

    <ErrorBoundary>
      <:default>
        {{#each this.items as |item|}}
          <ItemComponent @item={{item}} />
        {{/each}}
      </:default>
      <:error as |err retry|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}}
          <br />
          {{#if this.hasBomb}}
            <span class="hint status-bad">Items still contain "bomb" — Retry will re-catch. Click "Reset items" first.</span>
          {{else}}
            <span class="hint status-ok">Items are clean — Retry will recover.</span>
          {{/if}}
          <br />
          <button class="retry-btn" {{on "click" retry}}>Retry</button>
        </div>
      </:error>
    </ErrorBoundary>
  </template>
}
