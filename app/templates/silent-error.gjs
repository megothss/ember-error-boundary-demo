import DemoSection from 'error-boundary-demo/components/demo-section';
import SilentErrorDemo from 'error-boundary-demo/components/silent-error-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/silent-error-demo.gjs?raw';

const SNIPPET = `{{! No :error block = silent catch, no fallback UI }}
<ErrorBoundary>
  <AlwaysThrows />
</ErrorBoundary>
{{! The component threw but nothing rendered — no crash }}

{{! Compare with an explicit :error block: }}
<ErrorBoundary>
  <:default>
    <AlwaysThrows />
  </:default>
  <:error as |err|>
    Caught: {{err.message}}
  </:error>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="10. Silent Error Handling"
    @description="An ErrorBoundary with no error block silently catches errors. The errored subtree is removed from the DOM but the rest of the page stays intact."
  >
    <SilentErrorDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/silent-error-demo.gjs"
  />
</template>
