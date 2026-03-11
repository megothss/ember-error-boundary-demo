import DemoSection from 'error-boundary-demo/components/demo-section';
import EachInsertDemo from 'error-boundary-demo/components/each-insert-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/each-insert-demo.gjs?raw';

const SNIPPET = `<ErrorBoundary>
  <:default>
    {{#each this.items as |item|}}
      <ItemComponent @item={{item}} />
    {{/each}}
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
    @title="6. Each Loop Insert Error"
    @description="An each loop inside an ErrorBoundary. Click to add a bad item that throws during render."
  >
    <EachInsertDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/each-insert-demo.gjs"
  />
</template>
