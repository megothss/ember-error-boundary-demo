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

class RowItem extends Component {
  get label() {
    if (this.args.row.startsWith('bad')) {
      throw new Error(`${this.args.row} failed to render`);
    }
    return this.args.row;
  }

  <template>
    <span class="success row-chip" data-test-row-ok>{{this.label}}</span>
  </template>
}

let badRows = 0;

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

  @tracked rows = ['alpha', 'beta', 'gamma'];

  get hasBadRows() {
    return this.rows.some((row) => row.startsWith('bad'));
  }

  get rowsClean() {
    return !this.hasBadRows;
  }

  insertBadRow = () => {
    let middle = Math.floor(this.rows.length / 2);
    this.rows = [
      ...this.rows.slice(0, middle),
      `bad #${++badRows}`,
      ...this.rows.slice(middle),
    ];
  };

  prependBadRow = () => {
    this.rows = [`bad #${++badRows}`, ...this.rows];
  };

  reverseRows = () => {
    this.rows = [...this.rows].reverse();
  };

  removeBadRows = () => {
    this.rows = this.rows.filter((row) => !row.startsWith('bad'));
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

    <h4 class="sub">A boundary per row</h4>
    <p class="hint">
      Each row has its own boundary. A bad row inserted in the middle, prepended
      or moved by a reorder shows only its own fallback; the rows around it keep
      rendering, with no leftover markup from the failed attempt.
    </p>
    <div class="controls">
      <button
        class="trigger-btn"
        type="button"
        data-test-insert-bad-row
        {{on "click" this.insertBadRow}}
      >Insert bad row in the middle</button>
      <button
        class="trigger-btn"
        type="button"
        data-test-prepend-bad-row
        {{on "click" this.prependBadRow}}
      >Prepend bad row</button>
      <button
        class="trigger-btn"
        type="button"
        data-test-reverse-rows
        {{on "click" this.reverseRows}}
      >Reverse rows</button>
      <button
        class="fix-btn"
        disabled={{this.rowsClean}}
        type="button"
        data-test-remove-bad-rows
        {{on "click" this.removeBadRows}}
      >Remove bad rows</button>
    </div>
    <div class="rows" data-test-rows>
      {{#each this.rows key="@identity" as |row|}}
        <ErrorBoundary>
          <:try>
            <RowItem @row={{row}} />
          </:try>
          <:catch as |err|>
            <span
              class="error-box row-chip"
              data-test-row-failed
            >{{err.message}}</span>
          </:catch>
        </ErrorBoundary>
      {{/each}}
    </div>
  </template>
}
