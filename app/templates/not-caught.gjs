import DemoSection from 'error-boundary-demo/components/demo-section';
import NotCaughtDemo from 'error-boundary-demo/components/not-caught-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/not-caught-demo.gjs?raw';

const SNIPPET = `{{! Modifier errors escape ErrorBoundary }}
<ErrorBoundary>
  <:default>
    <div {{throwingModifier}}>...</div>
  </:default>
  <:error as |err|>
    This will NOT appear — modifier errors are not caught
  </:error>
</ErrorBoundary>

{{! Async errors also escape ErrorBoundary }}
setTimeout(() => { throw new Error('Not caught!'); }, 0);
Promise.resolve().then(() => { throw new Error('Not caught!'); });`;

<template>
  <DemoSection
    @title="9. Not Caught by ErrorBoundary"
    @description="ErrorBoundary only catches synchronous errors during render. Modifier install errors and async errors (setTimeout, Promises) escape the boundary."
  >
    <NotCaughtDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/not-caught-demo.gjs"
  />
</template>
