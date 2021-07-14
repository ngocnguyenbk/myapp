<template>
  <div class="d-inline-block">
    <nav class="d-inline-block ml-4">
      <Paginate
        v-show="showPaginate"
        v-model="pageNo"
        :click-handler="loadObjects"
        :page-count="totalPages"
        :container-class="'pagination'"
        :page-class="'page-item'"
        :page-link-class="'page-link'"
        :prev-class="'prev-item'"
        :prev-link-class="'page-link'"
        :next-class="'next-item'"
        :next-link-class="'page-link'"
        :break-view-class="'break-view'"
        :break-view-link-class="'break-view-link'"
      />
    </nav>
  </div>
</template>
<script>
import Paginate from 'vuejs-paginate';

export default {
  components: {
    Paginate,
  },
  props: {
    showPaginate: {
      type: Boolean,
    },
    currentPage: {
      type: Number,
      default: 0,
    },
    totalPages: {
      type: Number,
      default: 0,
    },
    loadObjects: {
      type: Function,
      default: () => 1,
    },
  },
  data: function() {
    return {
      pageNo: this.currentPage,
    };
  },
  watch: {
    currentPage: function(value) {
      this.pageNo = value;
    },
  },
};
</script>
