<template>
  <section class="demo-section">
    <h2>{{@title}}</h2>
    <p class="description">{{@description}}</p>
    <div class="demo-content">
      {{yield}}
    </div>
  </section>
</template>
