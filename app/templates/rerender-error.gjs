import DemoSection from 'error-boundary-demo/components/demo-section';
import RerenderDemo from 'error-boundary-demo/components/rerender-demo';

<template>
  <DemoSection
    @title="2. Rerender Error"
    @description="Renders fine initially. Click the button to flip tracked state, causing a throw on rerender."
  >
    <RerenderDemo />
  </DemoSection>
</template>
