import EmberRouter from '@ember/routing/router';
import config from 'error-boundary-demo/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('initial-render-error');
  this.route('rerender-error');
  this.route('retry-recovery');
  this.route('nested-boundaries');
  this.route('sibling-isolation');
  this.route('each-loop-insert');
  this.route('controller-error');
  this.route('outlet-layout', function () {
    this.route('child');
  });
  this.route('not-caught');
  this.route('silent-error');
  this.route('error-block-throws');
  this.route('sibling-update');
  this.route('in-element-portal');
});
