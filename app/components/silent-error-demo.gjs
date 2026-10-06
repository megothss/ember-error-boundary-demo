import { ErrorBoundary } from '@ember/component';
import AlwaysThrows from 'error-boundary-demo/components/always-throws';
import Counter from 'error-boundary-demo/components/counter';

<template>
  <p>
    When an
    <code>&lt;ErrorBoundary&gt;</code>
    has no
    <code>&lt;:catch&gt;</code>
    block, caught errors are silently swallowed and the errored subtree simply
    disappears from the DOM. This is useful for optional, non-critical UI where
    showing nothing is better than crashing.
  </p>

  <div class="siblings">
    <div class="sibling">
      <h3>No catch block (silent)</h3>
      <ErrorBoundary>
        <AlwaysThrows />
      </ErrorBoundary>
      <p class="hint">The component above threw, but nothing rendered — no
        crash, no fallback.</p>
    </div>
    <div class="sibling">
      <h3>With catch block (for comparison)</h3>
      <ErrorBoundary>
        <:try>
          <AlwaysThrows />
        </:try>
        <:catch as |err|>
          <div class="error-box">
            <strong>Caught!</strong>
            {{err.message}}
          </div>
        </:catch>
      </ErrorBoundary>
    </div>
  </div>

  <h4>Rest of the page is unaffected</h4>
  <div class="success">
    The silent boundary above didn't break anything.
    <Counter />
  </div>
</template>
