import Component from '@glimmer/component';

export default class AlwaysThrows extends Component {
  get bomb() {
    throw new Error('Component exploded during render!');
  }

  <template>
    <div>{{this.bomb}}</div>
  </template>
}
