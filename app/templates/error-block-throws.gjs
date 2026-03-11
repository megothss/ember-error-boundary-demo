import DemoSection from 'error-boundary-demo/components/demo-section';
import ErrorBlockThrowsDemo from 'error-boundary-demo/components/error-block-throws-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/error-block-throws-demo.gjs?raw';

const SNIPPET = `<ErrorBoundary>                    {{! Outer — catches bubbled error }}
  <:default>
    <ErrorBoundary>                {{! Inner — catches initial error }}
      <:default>
        <AlwaysThrows />
      </:default>
      <:error as |err|>
        Inner caught: {{err.message}}
        {{(throwInErrorBlock)}}      {{! This throws! }}
      </:error>
    </ErrorBoundary>
  </:default>
  <:error as |err|>
    Outer caught: {{err.message}}   {{! Catches the error block's throw }}
  </:error>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="11. Error Block Throws"
    @description="When the error block itself throws, the error bubbles up to the nearest parent ErrorBoundary."
  >
    <ErrorBlockThrowsDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/error-block-throws-demo.gjs"
  />
</template>
