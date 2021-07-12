<template>
  <li class="context-menu-item">
    <slot/>
  </li>
</template>

<script>
export default {

};
</script>

<style lang="scss" scoped>
  .context-menu-item {
    display: block;
    position: relative;
    padding: 2px 2px;
    background: #3c88f0;
    border-radius: 0;
    color: #FFF;
    text-decoration: none;
    font-size: 13px;
    width: 100%;
    text-align: left;
    cursor: pointer;
    padding:8px;
    &:not(:last-child) {
      border-bottom: 1px solid #ccc;
    }
    &:hover,
    &:focus {
      opacity: 0.7;
      color:#fff;
      outline: none;
    }
  }
</style>
