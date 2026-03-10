import DemoSection from 'error-boundary-demo/components/demo-section';
import InElementDemo from 'error-boundary-demo/components/in-element-demo';

<template>
  <DemoSection
    @title="13. In-Element Portal"
    @description="ErrorBoundary wrapping content rendered into a remote element via in-element. The boundary catches errors without leaking DOM into the portal target."
  >
    <InElementDemo />
  </DemoSection>
</template>
