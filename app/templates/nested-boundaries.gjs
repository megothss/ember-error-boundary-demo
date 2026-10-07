import AlwaysThrows from 'error-boundary-demo/components/always-throws';
import DemoSection from 'error-boundary-demo/components/demo-section';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import selfSource from './nested-boundaries.gjs?raw';

const SNIPPET = `{{#try}}           {{! Level 1 — unaffected }}
  {{#try}}       {{! Level 2 — unaffected }}
    {{#try}}   {{! Level 3 — catches }}
      <AlwaysThrows />
        {{catch as |err|}}
      Level 3 caught: {{err.message}}
    {{/try}}
  {{/try}}
{{/try}}`;

<template>
  <DemoSection
    @title="4. Nested Boundaries"
    @description="Three levels deep. Only the innermost boundary catches the error. Middle and outer boundaries remain unaffected."
  >
    {{#try}}
      <div class="nested-level" data-level="1">
        <span class="success">Level 1 — Outer boundary content is fine</span>
        {{#try}}
          <div class="nested-level" data-level="2">
            <span class="success">Level 2 — Middle boundary content is fine</span>
            {{#try}}
              <div class="nested-level" data-level="3">
                <AlwaysThrows />
              </div>
                {{catch as |err|}}
              <div class="error-box inner">
                <strong>Level 3 caught!</strong>
                {{err.message}}
              </div>
            {{/try}}
          </div>
          {{catch as |err|}}
          <div class="error-box">
            Level 2 caught (should NOT see this):
            {{err.message}}
          </div>
        {{/try}}
      </div>
    {{catch as |err|}}
      <div class="error-box">
        Level 1 caught (should NOT see this):
        {{err.message}}
      </div>
    {{/try}}
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{selfSource}}
    @sourceFile="app/templates/nested-boundaries.gjs"
  />
</template>
