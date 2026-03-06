import Component from '@glimmer/component';

export default class MaybeThrows extends Component {
  get value() {
    if (this.args.shouldThrow) {
      throw new Error('Boom! Tracked state caused a render error.');
    }
    return 'Rendered successfully';
  }

  <template>
    <div class="success">{{this.value}}</div>
  </template>
}
