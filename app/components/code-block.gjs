import highlight from 'error-boundary-demo/modifiers/highlight';

<template>
  <pre class="code-block"><code {{highlight @language}}>{{@code}}</code></pre>
</template>
