import CodeBlock from './code-block';

const GITHUB_BASE =
  'https://github.com/megothss/ember-error-boundary-demo/blob/main/';

<template>
  <div class="source-viewer">
    {{#if @snippet}}
      <h4 class="source-viewer-heading">Key Pattern</h4>
      <CodeBlock @code={{@snippet}} @language="handlebars" />
    {{/if}}

    {{#if @fullSource}}
      <details class="source-viewer-details">
        <summary>View full source</summary>
        <CodeBlock @code={{@fullSource}} @language="xml" />
      </details>
    {{/if}}

    {{#if @sourceFile}}
      <a
        class="source-viewer-github-link"
        href="{{GITHUB_BASE}}{{@sourceFile}}"
        target="_blank"
        rel="noopener noreferrer"
      >
        View on GitHub →
      </a>
    {{/if}}
  </div>
</template>
