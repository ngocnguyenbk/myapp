<template>
  <div>
    <button
      class="btn btn-primary"
      data-toggle="modal"
      data-target="#upload-file"
      @click="uploadFile"
    >
      {{ btnTitle }}
    </button>
    <div
      id="upload-file"
      class="modal fade"
      role="dialog"
      aria-modal="true"
      aria-hidden="true"
      data-backdrop="static"
      data-keyboard="false"
    >
      <div
        class="modal-dialog modal-dialog-centered modal-lg"
        role="document"
      >
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              {{ $t('upload_file.import_file') }}
            </h5>
          </div>
          <div class="modal-body">
            <form
              id="batch_create"
              class="batch_create"
              enctype="multipart/form-data"
              :action="action"
              accept-charset="UTF-8"
              method="post"
            >
              <input
                id="input_file"
                type="file"
                name="input-file[]"
                :accept="accept"
                data-browse-on-zone-click="true"
              >
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >
              {{ $t('upload_file.close') }}
            </button>
            <button
              type="button"
              class="btn btn-danger btn-delete"
              data-dismiss="modal"
              @click="submitForm"
            >
              {{ $t('upload_file.upload') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    accept: {
      type: String,
      required: true,
    },
    action: {
      type: String,
      required: true,
    },
    btnTitle: {
      type: String,
      required: true,
    },
  },
  data: function() {
    return {
      form: {},
    };
  },
  methods: {
    uploadFile: function() {
      this.createFile($('#input_file'));
    },
    createFile: function(input) {
      const self = this;

      input.fileinput({
        showUpload: false,
        showBrowse: false,
      }).on('fileselect', function(e) {
        self.handleFileUpload(e);
      });
    },
    submitForm: function() {
      const formUpload = $('#input_file').parents('form');
      const action = formUpload.attr('action');

      const formData = new FormData();
      formData.append('users[file]', this.form);
      formData.append('users[step]', 'confirmation');

      this.$store.dispatch(action, formData);
    },
    handleFileUpload: function(e) {
      const file = e.target.files[0];

      this.form = file;
    },
  },
};
</script>
