import LayoutWithBoundary from 'error-boundary-demo/components/layout-with-boundary';

<template>
  <div class="route-content">
    <h3>Layout Component Wrapping Outlet</h3>
    <LayoutWithBoundary>
      {{outlet}}
    </LayoutWithBoundary>
  </div>
</template>
