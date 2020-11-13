<template>
  <div
    class="context-menu"
    ref="popper"
    v-show="isVisible"
    tabindex="-1"
    v-click-outside="close"
    @contextmenu.capture.prevent>
    <ul>
      <slot/>
    </ul>
  </div>
</template>

<script>
import Popper from 'popper.js'
import ClickOutside from 'vue-click-outside'

export default {
  props: {
    boundariesElement: {
      type: String,
      default: 'body',
    },
  },
  components: {
    Popper,
  },
  data() {
    return {
      opened: false,
    }
  },
  directives:{
    ClickOutside,
  },
  computed: {
    isVisible() {
      return this.opened
    },
  },
  methods: {
    open(evt) {
      this.opened = true

      if (this.popper) {
        this.popper.destroy()
      }

      this.popper = new Popper(this.referenceObject(evt), this.$refs.popper, {
        placement: 'right-start',
        modifiers: {
          preventOverflow: {
            boundariesElement: document.querySelector(this.boundariesElement),
          },
        },
      })

      this.$nextTick(() => {
        this.popper.scheduleUpdate()
      })
    },
    close() {
      this.opened = false
      this.contextData = null
    },
    referenceObject(evt) {
      const left = evt.clientX
      const top = evt.clientY + 10
      const right = left + 1
      const bottom = top + 1
      const clientWidth = 1
      const clientHeight = 1

      function getBoundingClientRect() {
        return {
          left,
          top,
          right,
          bottom,
        }
      }

      const obj = {
        getBoundingClientRect,
        clientWidth,
        clientHeight,
      }
      window.localStorage.setItem('left', evt.clientX)
      window.localStorage.setItem('top', evt.clientY)
      return obj
    },
  },
  beforeDestroy() {
    if (this.popper !== undefined) {
      this.popper.destroy()
    }
  },
}

</script>

<style lang="scss" scoped>
  .context-menu {
    position: fixed;
    z-index: 999;
    overflow: hidden;
    background: #FFF;
    border-radius: 4px;
    box-shadow: 0 1px 4px 0 #eee;
    &:focus {
      outline: none;
    }

    ul {
      padding:0px;
      margin:0px;
    }
  }
</style>