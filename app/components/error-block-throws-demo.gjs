import { helper } from '@ember/component/helper';
import AlwaysThrows from 'error-boundary-demo/components/always-throws';

const throwInCatchBlock = helper(() => {
  throw new Error('Catch block itself exploded!');
});

<template>
  <p>
    When the
    <code>&lt;:error&gt;</code>
    block itself throws, the error bubbles up to the nearest parent
    <code>\{{#try}}</code>. This demonstrates proper error
    propagation through nested boundaries.
  </p>

  {{#try}}
    {{#try}}
      <AlwaysThrows />
      {{catch as |err|}}
      <p>Inner boundary caught: {{err.message}}</p>
      <p>But this helper will throw: {{(throwInCatchBlock)}}</p>
    {{/try}}
  {{catch as |err|}}
    <div class="error-box">
      <strong>Outer boundary caught!</strong>
      {{err.message}}
      <p class="hint">The inner boundary's catch block threw, so the error
        bubbled up here.</p>
    </div>
  {{/try}}
</template>
