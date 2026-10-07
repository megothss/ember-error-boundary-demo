import { helper } from '@ember/component/helper';
import AlwaysThrows from 'error-boundary-demo/components/always-throws';
import DemoSection from 'error-boundary-demo/components/demo-section';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import selfSource from './initial-render-error.gjs?raw';

const explodingHelper = helper(() => {
  throw new Error('Helper exploded!');
});

const SNIPPET = `{{#try}}
  <AlwaysThrows />
{{catch as |err|}}
  <div class="error-box">
    <strong>Caught!</strong> {{err.message}}
  </div>
{{/try}}`;

<template>
  <DemoSection
    @title="1. Initial Render Error"
    @description="A component and a helper that always throw during render. The boundary catches both immediately."
  >
    <h4>Component error</h4>
    {{#try}}
      <AlwaysThrows />
    {{catch as |err|}}
      <div class="error-box">
        <strong>Caught!</strong>
        {{err.message}}
      </div>
    {{/try}}

    <h4>Helper error</h4>
    {{#try}}
      <span>Result: {{(explodingHelper)}}</span>
    {{catch as |err|}}
      <div class="error-box">
        <strong>Caught!</strong>
        {{err.message}}
      </div>
    {{/try}}
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{selfSource}}
    @sourceFile="app/templates/initial-render-error.gjs"
  />
</template>
