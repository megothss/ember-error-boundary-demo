import { ErrorBoundary } from '@ember/component';
import { helper } from '@ember/component/helper';
import AlwaysThrows from 'error-boundary-demo/components/always-throws';

const throwInErrorBlock = helper(() => {
  throw new Error('Error block itself exploded!');
});

<template>
  <p>
    When the <code>&lt;:error&gt;</code> block itself throws, the error bubbles up to the
    nearest parent <code>&lt;ErrorBoundary&gt;</code>. This demonstrates proper error propagation
    through nested boundaries.
  </p>

  <ErrorBoundary>
    <:default>
      <ErrorBoundary>
        <:default>
          <AlwaysThrows />
        </:default>
        <:error as |err|>
          <p>Inner boundary caught: {{err.message}}</p>
          <p>But this helper will throw: {{(throwInErrorBlock)}}</p>
        </:error>
      </ErrorBoundary>
    </:default>
    <:error as |err|>
      <div class="error-box">
        <strong>Outer boundary caught!</strong> {{err.message}}
        <p class="hint">The inner boundary's error block threw, so the error bubbled up here.</p>
      </div>
    </:error>
  </ErrorBoundary>
</template>
