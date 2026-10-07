import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { next } from '@ember/runloop';
import { modifier } from 'ember-modifier';
import MaybeThrows from './maybe-throws';

/**
 * Plain counters, deliberately not tracked: they change during render, so the
 * panel re-reads them after each action instead.
 */
const stats = { created: 0, destroyed: 0, installed: 0, removed: 0 };

class Probe extends Component {
  constructor(owner, args) {
    super(owner, args);
    stats.created++;
  }

  willDestroy() {
    super.willDestroy();
    stats.destroyed++;
  }

  <template>
    <span class="hint">Probe component</span>
  </template>
}

const probe = modifier(() => {
  stats.installed++;
  return () => stats.removed++;
});

export default class LifecycleCleanupDemo extends Component {
  @tracked shouldThrow = false;
  @tracked tick = 0;

  constructor(owner, args) {
    super(owner, args);
    // The boundary renders after this panel, so show its first render's counts.
    this.refresh();
  }

  get counts() {
    // Read `tick` so the panel refreshes after every action.
    this.tick;
    return {
      ...stats,
      liveComponents: stats.created - stats.destroyed,
      liveModifiers: stats.installed - stats.removed,
    };
  }

  refresh() {
    // Destruction is scheduled on the run loop, so read the counters once it
    // has run. Staying on the run loop also lets test helpers wait for it.
    // eslint-disable-next-line ember/no-runloop
    next(() => next(() => this.tick++));
  }

  fail = () => {
    this.shouldThrow = true;
    this.refresh();
  };

  recover = () => {
    this.shouldThrow = false;
    this.refresh();
  };

  retryStillBroken = (retry) => {
    retry();
    this.refresh();
  };

  <template>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.shouldThrow}}
        type="button"
        data-test-fail-render
        {{on "click" this.fail}}
      >
        Fail the render
      </button>
      <button
        class="fix-btn"
        disabled={{if this.shouldThrow false true}}
        type="button"
        data-test-recover
        {{on "click" this.recover}}
      >
        Recover
      </button>
    </div>

    <table class="lifecycle-counts" data-test-lifecycle-counts>
      <thead>
        <tr><th></th><th>Created / installed</th><th>Destroyed</th><th
          >Live</th></tr>
      </thead>
      <tbody>
        <tr data-test-component-counts>
          <th>Components</th>
          <td>{{this.counts.created}}</td>
          <td>{{this.counts.destroyed}}</td>
          <td>{{this.counts.liveComponents}}</td>
        </tr>
        <tr data-test-modifier-counts>
          <th>Modifiers</th>
          <td>{{this.counts.installed}}</td>
          <td>{{this.counts.removed}}</td>
          <td>{{this.counts.liveModifiers}}</td>
        </tr>
      </tbody>
    </table>

    {{#try}}
      <Probe />
      <div class="success" {{probe}}>Element with a modifier</div>
      <MaybeThrows @shouldThrow={{this.shouldThrow}} />
    {{catch as |err retry|}}
      <div class="error-box">
        <strong>Caught!</strong>
        {{err.message}}
        <br />
        <span class="hint">Each retry while still broken creates a new Probe
          and destroys it again, and never installs its modifier on the
          discarded element. Live counts stay at zero.</span>
        <br />
        <button
          class="retry-btn"
          type="button"
          data-test-retry-broken
          {{on "click" (fn this.retryStillBroken retry)}}
        >Retry while still broken</button>
      </div>
    {{/try}}
  </template>
}
