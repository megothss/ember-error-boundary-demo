import DemoSection from 'error-boundary-demo/components/demo-section';
import RetryDemo from 'error-boundary-demo/components/retry-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/retry-demo.gjs?raw';

const SNIPPET = `<ErrorBoundary>
  <:default>
    <Fragile @shouldThrow={{this.shouldThrow}} />
    <Counter />
  </:default>
  <:error as |err retry|>
    <div class="error-box">
      <strong>Caught!</strong> {{err.message}}
      <button class="retry-btn" {{on "click" retry}}>Retry</button>
    </div>
  </:error>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="3. Retry & Recovery"
    @description="Trigger an error, fix the state, then click Retry to recover. Repeat the cycle multiple times — the boundary never gets stuck. The counter proves interactivity survives recovery."
  >
    <RetryDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/retry-demo.gjs"
  />
</template>
