import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { modifier } from 'ember-modifier';
import { ErrorBoundary } from '@ember/component';

const throwingModifier = modifier(() => {
  throw new Error('Modifier exploded during install!');
});

export default class NotCaughtDemo extends Component {
  @tracked log = '';
  @tracked showModifier = false;

  triggerModifier = () => {
    this.showModifier = true;
  };

  triggerAsync = () => {
    this.log = '';
    setTimeout(() => {
      this.log = 'setTimeout threw — check the browser console for the uncaught error.';
      throw new Error('Async error from setTimeout!');
    }, 100);
  };

  triggerPromise = () => {
    this.log = '';
    Promise.resolve().then(() => {
      this.log = 'Promise threw — check the browser console for the unhandled rejection.';
      throw new Error('Async error from Promise!');
    });
  };

  <template>
    <h4>Modifier Error</h4>
    <p class="hint">Modifiers run in transaction.commit() after the VM render pass. ErrorBoundary does NOT catch them.</p>
    <ErrorBoundary>
      <:default>
        {{#if this.showModifier}}
          <div {{throwingModifier}}>Content with a throwing modifier</div>
        {{else}}
          <div class="success">Modifier not triggered yet.</div>
        {{/if}}
      </:default>
      <:error as |err|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}} (this should not appear)
        </div>
      </:error>
    </ErrorBoundary>
    <div class="controls">
      <button class="trigger-btn" disabled={{this.showModifier}} {{on "click" this.triggerModifier}}>
        Trigger modifier error
      </button>
    </div>

    <h4>Async Errors</h4>
    <p class="hint">Errors in setTimeout or Promises happen outside the render cycle. ErrorBoundary does NOT catch them.</p>
    <div class="controls">
      <button class="trigger-btn" {{on "click" this.triggerAsync}}>
        Throw in setTimeout
      </button>
      <button class="trigger-btn" {{on "click" this.triggerPromise}}>
        Throw in Promise
      </button>
    </div>

    <ErrorBoundary>
      <:default>
        <div class="success">Still standing — async errors are NOT caught by ErrorBoundary.</div>
        {{#if this.log}}
          <p class="hint">{{this.log}}</p>
        {{/if}}
      </:default>
      <:error as |err|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}} (this should not appear)
        </div>
      </:error>
    </ErrorBoundary>
  </template>
}
