import DemoSection from 'error-boundary-demo/components/demo-section';
import LifecycleCleanupDemo from 'error-boundary-demo/components/lifecycle-cleanup-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/lifecycle-cleanup-demo.gjs?raw';

const SNIPPET = `<ErrorBoundary>
  <:try>
    <Probe />                                  {{! counts created/destroyed }}
    <div {{probe}}>Element with a modifier</div> {{! counts installed/removed }}
    <MaybeThrows @shouldThrow={{this.shouldThrow}} />
  </:try>
  <:catch as |err retry|>
    <button {{on "click" retry}}>Retry while still broken</button>
  </:catch>
</ErrorBoundary>`;

<template>
  <DemoSection
    @title="16. Lifecycle Cleanup"
    @description="A failed render leaves nothing behind. Every component it created is destroyed exactly once, and modifiers on its discarded elements are never installed. The live counts are one while the content renders and zero while the fallback shows, however many times you retry."
  >
    <LifecycleCleanupDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/lifecycle-cleanup-demo.gjs"
  />
</template>
