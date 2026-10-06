import DemoSection from 'error-boundary-demo/components/demo-section';
import FineGrainedRetryDemo from 'error-boundary-demo/components/fine-grained-retry-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/fine-grained-retry-demo.gjs?raw';

const SNIPPET = `{{! Widget reads @version and @broken, then throws while broken. }}
<ErrorBoundary>
  <:try>
    <Widget @version={{this.version}} @broken={{this.broken}} />
  </:try>
  <:catch as |err|>
    <div class="error-box">
      <strong>Caught!</strong> {{err.message}}
      Unrelated state: {{this.unrelated}}
    </div>
  </:catch>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="14. Fine-grained Retry"
    @description="The boundary remembers which tracked state the failed render read before it threw, and retries only when some of it changes. Bumping the version retries and catches again, since the widget is still broken. Changing unrelated state only updates the fallback. Fixing the widget recovers it."
  >
    <FineGrainedRetryDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/fine-grained-retry-demo.gjs"
  />
</template>
