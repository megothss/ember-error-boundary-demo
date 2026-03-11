import { on } from '@ember/modifier';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/controllers/controller-error.js?raw';

const SNIPPET = `{{! The route is wrapped by the app-level ErrorBoundary }}
{{! in application.gjs using @retryWith: }}

<ErrorBoundary @retryWith={{this.router.currentRouteName}}>
  <:default>
    {{outlet}}
  </:default>
  <:error as |err|>
    Route error caught! {{err.message}}
  </:error>
</ErrorBoundary>`;

<template>
  <div class="route-content">
    <h3>Controller Error Route</h3>
    <div class="success">{{@controller.value}}</div>
    <div class="controls">
      <button class="trigger-btn" disabled={{@controller.shouldThrow}} {{on "click" @controller.triggerError}}>
        Trigger controller error
      </button>
    </div>
  </div>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/controllers/controller-error.js"
  />
</template>
