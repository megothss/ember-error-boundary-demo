import { ErrorBoundary } from '@ember/component';

<template>
  <div class="layout-wrapper">
    <div class="layout-header">
      <strong>Layout Component</strong>
      — this stays intact when the child errors
    </div>
    <ErrorBoundary>
      <:try>
        {{yield}}
      </:try>
      <:catch as |err|>
        <div class="error-box">
          <strong>Layout boundary caught!</strong>
          {{err.message}}
          <br />
          <span class="hint">The layout stays intact. Navigate away to recover.</span>
        </div>
      </:catch>
    </ErrorBoundary>
  </div>
</template>
