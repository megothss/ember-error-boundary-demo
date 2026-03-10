import { ErrorBoundary } from '@ember/component';
import { helper } from '@ember/component/helper';
import AlwaysThrows from 'error-boundary-demo/components/always-throws';
import DemoSection from 'error-boundary-demo/components/demo-section';

const explodingHelper = helper(() => {
  throw new Error('Helper exploded!');
});

<template>
  <DemoSection
    @title="1. Initial Render Error"
    @description="A component and a helper that always throw during render. The boundary catches both immediately."
  >
    <h4>Component error</h4>
    <ErrorBoundary>
      <:default>
        <AlwaysThrows />
      </:default>
      <:error as |err|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}}
        </div>
      </:error>
    </ErrorBoundary>

    <h4>Helper error</h4>
    <ErrorBoundary>
      <:default>
        <span>Result: {{(explodingHelper)}}</span>
      </:default>
      <:error as |err|>
        <div class="error-box">
          <strong>Caught!</strong> {{err.message}}
        </div>
      </:error>
    </ErrorBoundary>
  </DemoSection>
</template>
