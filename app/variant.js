/**
 * Where the same demos written with the `<ErrorBoundary>` component live. In
 * production this keyword build is served from `keyword/` under the component
 * site; locally, point `VITE_COMPONENT_DEMO_URL` at its dev server.
 */
export const COMPONENT_DEMO_URL =
  import.meta.env.VITE_COMPONENT_DEMO_URL ?? import.meta.env.BASE_URL.replace(/keyword\/$/, '');
