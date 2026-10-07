import DemoSection from 'error-boundary-demo/components/demo-section';
import ErrorBlockThrowsDemo from 'error-boundary-demo/components/error-block-throws-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/error-block-throws-demo.gjs?raw';

const SNIPPET = `{{#try}}                    {{! Outer — catches bubbled error }}
  {{#try}}                {{! Inner — catches initial error }}
    <AlwaysThrows />
    {{catch as |err|}}
    Inner caught: {{err.message}}
    {{(throwInCatchBlock)}}      {{! This throws! }}
  {{/try}}
{{catch as |err|}}
  Outer caught: {{err.message}}   {{! Catches the catch block's throw }}
{{/try}}`;

<template>
  <DemoSection
    @title="11. Catch Block Throws"
    @description="When the catch block itself throws, the error bubbles up to the nearest enclosing try block."
  >
    <ErrorBlockThrowsDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/error-block-throws-demo.gjs"
  />
</template>
