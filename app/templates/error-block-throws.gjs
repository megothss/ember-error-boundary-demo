import DemoSection from 'error-boundary-demo/components/demo-section';
import ErrorBlockThrowsDemo from 'error-boundary-demo/components/error-block-throws-demo';

<template>
  <DemoSection
    @title="11. Error Block Throws"
    @description="When the error block itself throws, the error bubbles up to the nearest parent ErrorBoundary."
  >
    <ErrorBlockThrowsDemo />
  </DemoSection>
</template>
