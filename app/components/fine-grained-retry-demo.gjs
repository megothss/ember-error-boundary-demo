import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

let attempts = 0;

class Widget extends Component {
  get value() {
    attempts++;

    // Both args are read before the throw, so the boundary retries when
    // either one changes.
    let { version, broken } = this.args;
    if (broken) {
      throw new Error(
        `Render failed at version ${version} (attempt #${attempts})`
      );
    }
    return `Rendered version ${version} (attempt #${attempts})`;
  }

  <template>
    <div class="success">{{this.value}}</div>
  </template>
}

export default class FineGrainedRetryDemo extends Component {
  @tracked broken = false;
  @tracked unrelated = 'blue';
  @tracked version = 1;

  breakIt = () => (this.broken = true);
  bumpVersion = () => this.version++;
  changeUnrelated = () =>
    (this.unrelated = this.unrelated === 'blue' ? 'green' : 'blue');
  fix = () => (this.broken = false);

  get isOk() {
    return !this.broken;
  }

  <template>
    <div class="controls">
      <button
        class="trigger-btn"
        disabled={{this.broken}}
        type="button"
        data-test-break
        {{on "click" this.breakIt}}
      >
        Break
      </button>
      <button
        type="button"
        data-test-bump-version
        {{on "click" this.bumpVersion}}
      >
        Bump version (read before the throw)
      </button>
      <button
        type="button"
        data-test-change-unrelated
        {{on "click" this.changeUnrelated}}
      >
        Change unrelated state
      </button>
      <button
        class="fix-btn"
        disabled={{this.isOk}}
        type="button"
        data-test-fix
        {{on "click" this.fix}}
      >
        Fix
      </button>
    </div>

    {{#try}}
      <Widget @version={{this.version}} @broken={{this.broken}} />
    {{catch as |err|}}
      <div class="error-box">
        <strong>Caught!</strong>
        <span data-test-error-message>{{err.message}}</span>
        <br />
        <span class="hint">Unrelated state:
          <strong data-test-unrelated-in-fallback>{{this.unrelated}}</strong>.
          Changing it updates this fallback but never retries, because the
          failed render didn't read it. Watch the attempt number.</span>
      </div>
    {{/try}}
  </template>
}
