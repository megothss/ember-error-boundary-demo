import DemoSection from 'error-boundary-demo/components/demo-section';
import SiblingUpdateDemo from 'error-boundary-demo/components/sibling-update-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/sibling-update-demo.gjs?raw';

const SNIPPET = `{{! ErrorBoundary followed by sibling with tracked state }}
<ErrorBoundary>
  <:default>
    <div class="success">No error here.</div>
  </:default>
  <:error as |err|>
    Caught: {{err.message}}
  </:error>
</ErrorBoundary>

{{! Sibling content — tracked updates must work }}
<div>
  <p>{{this.label}}</p>
  <button {{on "click" this.changeLabel}}>Toggle label</button>
  <Counter />
</div>`;

<template>
  <DemoSection
    @title="12. Sibling Update After Boundary"
    @description="Content rendered after an ErrorBoundary with tracked state updates. Proves the block stack stays balanced — without the fix, toggling the sibling's state crashes the app."
  >
    <SiblingUpdateDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/sibling-update-demo.gjs"
  />
</template>
