/**
 * Where the same demos written with the `{{#try}}` keyword live. In production
 * that build is served from `keyword/` under this site; locally, point
 * `VITE_KEYWORD_DEMO_URL` at its dev server.
 */
export const KEYWORD_DEMO_URL =
  import.meta.env.VITE_KEYWORD_DEMO_URL ??
  `${import.meta.env.BASE_URL}keyword/`;
