import { module, test } from 'qunit';
import { click, visit } from '@ember/test-helpers';
import { setupApplicationTest } from 'error-boundary-demo/tests/helpers';

module('Acceptance | hardening scenarios', function (hooks) {
  setupApplicationTest(hooks);

  test('a fallback that breaks while showing is caught by the outer boundary', async function (assert) {
    await visit('/fallback-errors');
    assert.dom('[data-test-inner-fallback]').includesText('Component exploded');
    assert.dom('[data-test-outer-fallback]').doesNotExist();

    await click('[data-test-break-fallback]');
    assert
      .dom('[data-test-outer-fallback]')
      .includesText('The inner fallback broke');
    assert.dom('[data-test-inner-fallback]').doesNotExist();

    await click('[data-test-repair-fallback]');
    assert.dom('[data-test-outer-fallback]').doesNotExist();
    assert.dom('[data-test-inner-fallback]').includesText('Component exploded');
  });

  test('failed renders leave no live components or modifiers', async function (assert) {
    await visit('/lifecycle-cleanup');
    assert.dom('[data-test-component-counts] td:last-child').hasText('1');
    assert.dom('[data-test-modifier-counts] td:last-child').hasText('1');

    await click('[data-test-fail-render]');
    assert.dom('[data-test-component-counts] td:last-child').hasText('0');
    assert.dom('[data-test-modifier-counts] td:last-child').hasText('0');

    let installed = Number(
      document.querySelector('[data-test-modifier-counts] td').textContent
    );
    await click('[data-test-retry-broken]');
    await click('[data-test-retry-broken]');
    assert.dom('[data-test-component-counts] td:last-child').hasText('0');
    assert.dom('[data-test-modifier-counts] td:last-child').hasText('0');
    assert
      .dom('[data-test-modifier-counts] td')
      .hasText(String(installed), 'retries never install the modifier');

    await click('[data-test-recover]');
    assert.dom('[data-test-component-counts] td:last-child').hasText('1');
    assert.dom('[data-test-modifier-counts] td:last-child').hasText('1');
  });

  test('a bad row fails alone wherever it lands', async function (assert) {
    await visit('/each-loop-insert');
    assert.dom('[data-test-row-ok]').exists({ count: 3 });

    await click('[data-test-insert-bad-row]');
    assert.dom('[data-test-row-failed]').exists({ count: 1 });
    assert.dom('[data-test-row-ok]').exists({ count: 3 });

    await click('[data-test-prepend-bad-row]');
    await click('[data-test-reverse-rows]');
    assert.dom('[data-test-row-failed]').exists({ count: 2 });
    assert.dom('[data-test-row-ok]').exists({ count: 3 });
    assert.dom('[data-test-rows]').hasText(/gamma.*beta.*alpha/s);

    await click('[data-test-remove-bad-rows]');
    assert.dom('[data-test-row-failed]').doesNotExist();
    assert.dom('[data-test-row-ok]').exists({ count: 3 });
  });

  test('a fallback rendered into the same portal replaces the failed content', async function (assert) {
    await visit('/in-element-portal');
    assert.dom('[data-test-portal-shared] [data-test-shared-body]').exists();

    await click('[data-test-trigger-shared]');
    assert
      .dom('[data-test-portal-shared] [data-test-shared-body]')
      .doesNotExist();
    assert
      .dom('[data-test-portal-shared] [data-test-shared-fallback]')
      .exists({ count: 1 });
    assert.dom('[data-test-portal-shared] .existing-content').exists();

    await click('[data-test-reset-shared]');
    assert
      .dom('[data-test-portal-shared] [data-test-shared-fallback]')
      .doesNotExist();
    assert
      .dom('[data-test-portal-shared] [data-test-shared-body]')
      .exists({ count: 1 });
  });
});
