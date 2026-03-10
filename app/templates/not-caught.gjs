import DemoSection from 'error-boundary-demo/components/demo-section';
import NotCaughtDemo from 'error-boundary-demo/components/not-caught-demo';

<template>
  <DemoSection
    @title="9. Not Caught by ErrorBoundary"
    @description="ErrorBoundary only catches synchronous errors during render. Modifier install errors and async errors (setTimeout, Promises) escape the boundary."
  >
    <NotCaughtDemo />
  </DemoSection>
</template>
