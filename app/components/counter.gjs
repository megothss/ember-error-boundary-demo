import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

export default class Counter extends Component {
  @tracked count = 0;

  increment = () => this.count++;

  <template>
    <span class="counter">
      Count: <strong>{{this.count}}</strong>
      <button {{on "click" this.increment}}>+1</button>
    </span>
  </template>
}
