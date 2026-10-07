import DemoSection from 'error-boundary-demo/components/demo-section';
import InElementDemo from 'error-boundary-demo/components/in-element-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/in-element-demo.gjs?raw';

const SNIPPET = `{{! A try block wrapping an in-element portal }}
{{#try}}
  {{#in-element this.portalTarget}}
    <MaybeThrows @shouldThrow={{this.shouldThrow}} />
  {{/in-element}}
{{catch as |err|}}
  <div class="error-box">
    Caught: {{err.message}}
    <button {{on "click" this.reset}}>Reset</button>
  </div>
{{/try}}`;

<template>
  <DemoSection
    @title="13. In-Element Portal"
    @description="A try block wrapping content rendered into a remote element via in-element. The boundary catches errors without leaking DOM into the portal target, even when its fallback renders into that same target."
  >
    <InElementDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/in-element-demo.gjs"
  />
</template>
