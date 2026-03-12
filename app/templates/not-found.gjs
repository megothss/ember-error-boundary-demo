import { LinkTo } from '@ember/routing';
import DemoSection from 'error-boundary-demo/components/demo-section';

<template>
  <DemoSection
    @title="404 — Page Not Found"
    @description="The page you're looking for doesn't exist."
  >
    <LinkTo @route="index">← Back to home</LinkTo>
  </DemoSection>
</template>
