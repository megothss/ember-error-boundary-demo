import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class ControllerErrorController extends Controller {
  @tracked shouldThrow = false;

  get value() {
    if (this.shouldThrow) {
      throw new Error('Controller getter exploded!');
    }
    return 'Rendered successfully — click the button to trigger an error';
  }

  triggerError = () => {
    this.shouldThrow = true;
  };
}
