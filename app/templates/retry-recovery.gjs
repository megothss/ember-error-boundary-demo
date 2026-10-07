import DemoSection from 'error-boundary-demo/components/demo-section';
import RetryDemo from 'error-boundary-demo/components/retry-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/retry-demo.gjs?raw';

const SNIPPET = `{{#try}}
  <Fragile @shouldThrow={{this.shouldThrow}} @requestId={{this.requestId}} />
  <Counter />
{{catch as |err retry|}}
  <div class="error-box">
    <strong>Caught!</strong> {{err.message}}
    <button class="retry-btn" {{on "click" retry}}>Retry</button>
  </div>
{{/try}}`;

<template>
  <DemoSection
    @title="3. Retry & Recovery"
    @description="A boundary retries on its own when tracked state its failed render read changes, so fixing that state is enough. The retry block param covers what tracking can't see: a failure from untracked state, like an outage, needs a manual Retry once it is resolved. The counter proves interactivity survives recovery."
  >
    <RetryDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/retry-demo.gjs"
  />
</template>
