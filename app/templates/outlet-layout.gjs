import LayoutWithBoundary from 'error-boundary-demo/components/layout-with-boundary';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/layout-with-boundary.gjs?raw';

const SNIPPET = `{{! layout-with-boundary.gjs }}
<div class="layout-wrapper">
  <div class="layout-header">
    Layout Component — stays intact when the child errors
  </div>
  <ErrorBoundary>
    <:default>
      {{yield}}
    </:default>
    <:error as |err|>
      Layout boundary caught! {{err.message}}
    </:error>
  </ErrorBoundary>
</div>`;

<template>
  <div class="route-content">
    <h3>Layout Component Wrapping Outlet</h3>
    <LayoutWithBoundary>
      {{outlet}}
    </LayoutWithBoundary>
  </div>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/layout-with-boundary.gjs"
  />
</template>
