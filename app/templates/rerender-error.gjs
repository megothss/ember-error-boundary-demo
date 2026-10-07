import DemoSection from 'error-boundary-demo/components/demo-section';
import RerenderDemo from 'error-boundary-demo/components/rerender-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/rerender-demo.gjs?raw';

const SNIPPET = `{{#try}}
  <MaybeThrows @shouldThrow={{this.shouldThrow}} />
{{catch as |err|}}
  <div class="error-box">
    <strong>Caught on rerender!</strong> {{err.message}}
  </div>
{{/try}}`;

<template>
  <DemoSection
    @title="2. Rerender Error"
    @description="Renders fine initially. Click the button to flip tracked state, causing a throw on rerender."
  >
    <RerenderDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/rerender-demo.gjs"
  />
</template>
