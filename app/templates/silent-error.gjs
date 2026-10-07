import DemoSection from 'error-boundary-demo/components/demo-section';
import SilentErrorDemo from 'error-boundary-demo/components/silent-error-demo';
import SourceViewer from 'error-boundary-demo/components/source-viewer';

import fullSource from 'error-boundary-demo/components/silent-error-demo.gjs?raw';

const SNIPPET = `{{! No {{catch}} block = silent catch, no fallback UI }}
{{#try}}
  <AlwaysThrows />
{{/try}}
{{! The component threw but nothing rendered — no crash }}

{{! Compare with a {{catch}} block: }}
{{#try}}
  <AlwaysThrows />
{{catch as |err|}}
  Caught: {{err.message}}
{{/try}}`;

<template>
  <DemoSection
    @title="10. Silent Error Handling"
    @description="A try block with no catch block silently catches errors. The errored subtree is removed from the DOM but the rest of the page stays intact."
  >
    <SilentErrorDemo />
  </DemoSection>

  <SourceViewer
    @snippet={{SNIPPET}}
    @fullSource={{fullSource}}
    @sourceFile="app/components/silent-error-demo.gjs"
  />
</template>
