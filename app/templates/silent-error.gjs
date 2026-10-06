import DemoSection from 'error-boundary-demo/components/demo-section';
import SilentErrorDemo from 'error-boundary-demo/components/silent-error-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/silent-error-demo.gjs?raw';

const SNIPPET = `{{! No <:catch> block = silent catch, no fallback UI }}
<ErrorBoundary>
  <AlwaysThrows />
</ErrorBoundary>
{{! The component threw but nothing rendered — no crash }}

{{! Compare with a <:catch> block: }}
<ErrorBoundary>
  <:try>
    <AlwaysThrows />
  </:try>
  <:catch as |err|>
    Caught: {{err.message}}
  </:catch>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="10. Silent Error Handling"
    @description="An ErrorBoundary with no catch block silently catches errors. The errored subtree is removed from the DOM but the rest of the page stays intact."
  >
    <SilentErrorDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/silent-error-demo.gjs"
  />
</template>
