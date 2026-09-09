export default {
  extends: 'recommended',

  // CI checks the ember-source fork out here to build it; it is not our code.
  ignore: ['ember-source-fork/**'],
};
