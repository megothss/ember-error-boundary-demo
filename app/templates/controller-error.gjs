import { on } from '@ember/modifier';

<template>
  <div class="route-content">
    <h3>Controller Error Route</h3>
    <div class="success">{{@controller.value}}</div>
    <div class="controls">
      <button class="trigger-btn" disabled={{@controller.shouldThrow}} {{on "click" @controller.triggerError}}>
        Trigger controller error
      </button>
    </div>
  </div>
</template>
