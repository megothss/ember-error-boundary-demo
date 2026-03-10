import DemoSection from 'error-boundary-demo/components/demo-section';
import SilentErrorDemo from 'error-boundary-demo/components/silent-error-demo';

<template>
  <DemoSection
    @title="10. Silent Error Handling"
    @description="An ErrorBoundary with no error block silently catches errors. The errored subtree is removed from the DOM but the rest of the page stays intact."
  >
    <SilentErrorDemo />
  </DemoSection>
</template>
