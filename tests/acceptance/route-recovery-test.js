import { module, test } from 'qunit';
import { click, visit } from '@ember/test-helpers';
import { setupApplicationTest } from 'error-boundary-demo/tests/helpers';

module('Acceptance | route error recovery', function (hooks) {
  setupApplicationTest(hooks);

  test('navigating away recovers the app-level boundary', async function (assert) {
    await visit('/controller-error');
    await click('.trigger-btn');

    assert
      .dom('.content-area .error-box')
      .includesText('Controller getter exploded!');

    // The failed render read the outlet state before it threw, so a route
    // change is enough to make the boundary retry. No @retryWith needed.
    await visit('/rerender-error');

    assert.dom('.content-area .error-box').doesNotExist();
    assert.dom('.content-area h2').hasText('2. Rerender Error');
  });
});
