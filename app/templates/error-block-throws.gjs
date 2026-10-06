import DemoSection from 'error-boundary-demo/components/demo-section';
import ErrorBlockThrowsDemo from 'error-boundary-demo/components/error-block-throws-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/error-block-throws-demo.gjs?raw';

const SNIPPET = `<ErrorBoundary>                    {{! Outer — catches bubbled error }}
  <:try>
    <ErrorBoundary>                {{! Inner — catches initial error }}
      <:try>
        <AlwaysThrows />
      </:try>
      <:catch as |err|>
        Inner caught: {{err.message}}
        {{(throwInCatchBlock)}}      {{! This throws! }}
      </:catch>
    </ErrorBoundary>
  </:try>
  <:catch as |err|>
    Outer caught: {{err.message}}   {{! Catches the catch block's throw }}
  </:catch>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="11. Catch Block Throws"
    @description="When the catch block itself throws, the error bubbles up to the nearest parent ErrorBoundary."
  >
    <ErrorBlockThrowsDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/error-block-throws-demo.gjs"
  />
</template>
