import { ErrorBoundary } from '@ember/component';

<template>
  <div class="layout-wrapper">
    <div class="layout-header">
      <strong>Layout Component</strong> — this stays intact when the child errors
    </div>
    <ErrorBoundary>
      <:default>
        {{yield}}
      </:default>
      <:error as |err|>
        <div class="error-box">
          <strong>Layout boundary caught!</strong> {{err.message}}
          <br />
          <span class="hint">The layout stays intact. Navigate away to recover.</span>
        </div>
      </:error>
    </ErrorBoundary>
  </div>
</template>
