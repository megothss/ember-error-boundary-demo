import AlwaysThrows from 'error-boundary-demo/components/always-throws';
import Counter from 'error-boundary-demo/components/counter';
import DemoSection from 'error-boundary-demo/components/demo-section';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import selfSource from './sibling-isolation.gjs?raw';

const SNIPPET = `<div class="siblings">
  {{#try}}    {{! Boundary A — errors }}
    <AlwaysThrows />
  {{catch as |err|}}
    A caught: {{err.message}}
  {{/try}}

  {{#try}}    {{! Boundary B — unaffected }}
    <Counter />
  {{/try}}
</div>`;

<template>
  <DemoSection
    @title="5. Sibling Isolation"
    @description="Two sibling boundaries — one errors, the other keeps working independently."
  >
    <div class="siblings">
      <div class="sibling">
        <h3>Boundary A (errors)</h3>
        {{#try}}
          <AlwaysThrows />
        {{catch as |err|}}
          <div class="error-box">
            <strong>A caught!</strong>
            {{err.message}}
          </div>
        {{/try}}
      </div>
      <div class="sibling">
        <h3>Boundary B (works fine)</h3>
        {{#try}}
          <div class="success">
            No errors here!
            <Counter />
          </div>
        {{catch as |err|}}
          <div class="error-box">
            B caught:
            {{err.message}}
          </div>
        {{/try}}
      </div>
    </div>
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{selfSource}}
    @sourceFile="app/templates/sibling-isolation.gjs"
  />
</template>
