import DemoSection from 'error-boundary-demo/components/demo-section';
import RetryDemo from 'error-boundary-demo/components/retry-demo';

<template>
  <DemoSection
    @title="3. Retry & Recovery"
    @description="Trigger an error, fix the state, then click Retry to recover. Repeat the cycle multiple times — the boundary never gets stuck. The counter proves interactivity survives recovery."
  >
    <RetryDemo />
  </DemoSection>
</template>
