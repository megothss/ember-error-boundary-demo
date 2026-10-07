import DemoSection from 'error-boundary-demo/components/demo-section';
import FallbackErrorsDemo from 'error-boundary-demo/components/fallback-errors-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/fallback-errors-demo.gjs?raw';

const SNIPPET = `{{#try}}                 {{! Outer }}
  {{#try}}             {{! Inner: its content always throws }}
    <AlwaysThrows />
    {{catch as |err|}}
    {{! Throws once this.fallbackBroken is true }}
    <InnerFallback @error={{err}} @broken={{this.fallbackBroken}} />
  {{/try}}
{{catch as |err|}}
  <div class="error-box">Outer boundary caught: {{err.message}}</div>
{{/try}}`;

<template>
  <DemoSection
    @title="15. Fallback Errors"
    @description="A fallback that breaks while it is showing is not caught by its own boundary: the error goes to the next boundary out. Break the inner fallback and the outer boundary catches it. Repair it and the outer boundary retries on its own."
  >
    <FallbackErrorsDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/fallback-errors-demo.gjs"
  />
</template>
