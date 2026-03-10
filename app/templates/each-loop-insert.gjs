import DemoSection from 'error-boundary-demo/components/demo-section';
import EachInsertDemo from 'error-boundary-demo/components/each-insert-demo';

<template>
  <DemoSection
    @title="6. Each Loop Insert Error"
    @description="An each loop inside an ErrorBoundary. Click to add a bad item that throws during render."
  >
    <EachInsertDemo />
  </DemoSection>
</template>
