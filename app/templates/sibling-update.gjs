import DemoSection from 'error-boundary-demo/components/demo-section';
import SiblingUpdateDemo from 'error-boundary-demo/components/sibling-update-demo';

<template>
  <DemoSection
    @title="12. Sibling Update After Boundary"
    @description="Content rendered after an ErrorBoundary with tracked state updates. Proves the block stack stays balanced — without the fix, toggling the sibling's state crashes the app."
  >
    <SiblingUpdateDemo />
  </DemoSection>
</template>
