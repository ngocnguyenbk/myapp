<template>
  <div class="form-group row">
    <label
      :for="inputId"
      :class="['col-form-label', colLabel]"
    >{{ labelText }}</label>
    <div :class="[colInput]">
      <transition
        name="fade"
        mode="out-in"
      >
        <div
          v-if="!image"
          :key="'input_image_file_' + inputId"
        >
          <input
            :id="inputId"
            ref="file"
            :accept="accept"
            type="file"
            :disabled="disabled"
            class="d-none"
            @change="onFileChange"
          >
          <button
            type="button"
            class="btn btn-light"
            @click="$refs.file.click()"
          >
            <i
              class="fa fa-upload"
              aria-hidden="true"
            />
            {{ $t('input_image_file.select_file') }}
          </button>
          <span
            v-if="eMsg"
            class="text-danger"
          >{{ eMsg }}</span>
        </div>
        <div
          v-else
          :key="'input_image_file_1_' + inputId"
        >
          <img
            :src="image"
            :width="width"
            :height="height"
            class="img-thumbnail"
          >
          <span>{{ fileName || emptyText }}</span>
          <button
            class="btn btn-light"
            @click.prevent="removeImage"
          >
            {{ $t('input_image_file.remove') }}
            <i
              class="fa fa-times-circle"
              aria-hidden="true"
            />
          </button>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
export default ({
  props: {
    inputId: {
      type: String,
      default: '',
      require: true,
    },
    labelText: {
      type: String,
      default: '',
      require: true,
    },
    eMsg: {
      type: String,
      default: '',
    },
    accept: {
      type: String,
      default: '',
      require: true,
    },
    colLabel: {
      type: String,
      default: 'col-lg-2',
    },
    colInput: {
      type: String,
      default: 'col-lg-10',
    },
    disabled: {
      type: Boolean,
    },
    width: {
      type: [Number, String],
      default: 100,
    },
    height: {
      type: [Number, String],
      default: 100,
    }
  },
  data: function() {
    return {
      image: '',
      emptyText: this.$t('input_image_file.empty_chosen'),
      fileName: '',
    }
  },
  methods: {
    onFileChange(e) {
      const files = e.target.files || e.dataTransfer.files;
      if (!files.length)
        return;
      this.$emit('change', files[0]);
      this.createImage(files[0]);
    },
    createImage(file) {
      const reader = new FileReader();
      const self = this;

      reader.onload = (e) => {
        self.image = e.target.result;
        self.fileName = file.name;
      };
      reader.readAsDataURL(file);
    },
    removeImage: function (e) {
      this.image = '';
    }
  }
})
</script>

<style lang="scss" scoped>
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>
