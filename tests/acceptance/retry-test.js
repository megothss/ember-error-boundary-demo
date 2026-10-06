import { module, test } from 'qunit';
import { click, find, visit } from '@ember/test-helpers';
import { setupApplicationTest } from 'error-boundary-demo/tests/helpers';

module('Acceptance | retry', function (hooks) {
  setupApplicationTest(hooks);

  test('fixing tracked state recovers without clicking Retry', async function (assert) {
    await visit('/retry-recovery');
    await click('[data-test-break-state]');

    assert.dom('.error-box').includesText('Tracked state is broken');

    await click('[data-test-fix-state]');

    assert.dom('.error-box').doesNotExist();
    assert.dom('.success').includesText('Rendered OK');
  });

  test('an untracked failure needs Retry once it is resolved', async function (assert) {
    await visit('/retry-recovery');
    await click('[data-test-start-outage]');

    assert.dom('.error-box').includesText('Service unavailable');

    // Ending the outage changes untracked state, so the boundary cannot know.
    await click('[data-test-end-outage]');
    assert.dom('.error-box').includesText('Service unavailable');

    await click('.error-box [data-test-retry]');

    assert.dom('.error-box').doesNotExist();
    assert.dom('.success').includesText('Rendered OK');
  });

  test('retries only when state the failed render read changes', async function (assert) {
    await visit('/fine-grained-retry');
    await click('[data-test-break]');

    assert.dom('.error-box').includesText('Render failed at version 1');
    let firstMessage = find('[data-test-error-message]').textContent;

    // Not read by the failed render: the fallback updates, no retry happens.
    await click('[data-test-change-unrelated]');
    assert.dom('[data-test-unrelated-in-fallback]').hasText('green');
    assert.dom('[data-test-error-message]').hasText(firstMessage);

    // Read by the failed render: the boundary retries, and catches again.
    await click('[data-test-bump-version]');
    assert.dom('.error-box').includesText('Render failed at version 2');
    assert
      .dom('[data-test-error-message]')
      .doesNotHaveTextContaining(firstMessage);

    await click('[data-test-fix]');
    assert.dom('.error-box').doesNotExist();
    assert.dom('.success').includesText('Rendered version 2');
  });

  test('resetting each-loop items recovers without clicking Retry', async function (assert) {
    await visit('/each-loop-insert');
    await click('[data-test-add-bad-item]');

    assert.dom('.error-box').includesText('bomb item exploded');

    await click('[data-test-reset-items]');

    assert.dom('.error-box').doesNotExist();
    assert.dom('.item').exists({ count: 2 });
  });

  test('resetting state recovers a boundary around in-element', async function (assert) {
    await visit('/in-element-portal');
    await click('[data-test-trigger-default]');

    assert.dom('#portal-default-2').doesNotIncludeText('portaled here');

    await click('[data-test-reset-default]');

    assert.dom('#portal-default-2').includesText('portaled here');
  });
});
