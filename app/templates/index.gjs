<template>
  <div class="homepage">
    <div class="homepage-banner">
      Work in Progress
    </div>

    <h2 class="homepage-title">Error Boundaries for Ember</h2>

    <p class="homepage-text">
      Today, if a component throws an error during rendering, the entire
      application crashes. There is no way to contain the failure to just
      the broken part of the page. Users see a blank screen or a full-page
      error, even if the problem is in a single widget or sidebar.
    </p>

    <p class="homepage-text">
      Error boundaries change that. Wrap any part of your template in an
      ErrorBoundary component, and if something inside it throws during
      render or rerender, the boundary catches the error and displays
      fallback UI. The rest of the application keeps working normally.
    </p>

    <p class="homepage-text">
      This demo app is a proof-of-concept exploring this feature for Ember.js.
      It is being developed independently and is <strong>not an official
      Ember project</strong>. The underlying Ember fork should not be used
      outside of development and testing.
    </p>

    <p class="homepage-cta">
      Select a scenario from the sidebar to get started.
    </p>
  </div>
</template>
