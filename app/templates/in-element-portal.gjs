import DemoSection from 'error-boundary-demo/components/demo-section';
import InElementDemo from 'error-boundary-demo/components/in-element-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/in-element-demo.gjs?raw';

const SNIPPET = `{{! ErrorBoundary wrapping an in-element portal }}
<ErrorBoundary>
  <:default>
    {{#in-element this.portalTarget}}
      <MaybeThrows @shouldThrow={{this.shouldThrow}} />
    {{/in-element}}
  </:default>
  <:error as |err retry|>
    <div class="error-box">
      Caught: {{err.message}}
      <button {{on "click" (fn this.resetAndRetry retry)}}>
        Reset &amp; Retry
      </button>
    </div>
  </:error>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="13. In-Element Portal"
    @description="ErrorBoundary wrapping content rendered into a remote element via in-element. The boundary catches errors without leaking DOM into the portal target."
  >
    <InElementDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/in-element-demo.gjs"
  />
</template>
