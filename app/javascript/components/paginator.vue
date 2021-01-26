<template>
  <div class="d-inline-block">
    <nav class="d-inline-block ml-4">
      <Paginate
        v-model="pageNo"
        v-show="showPaginate"
        :click-handler="loadObjects"
        :pageCount="totalPages"
        :container-class="'pagination'"
        :page-class="'page-item'"
        :page-link-class="'page-link'"
        :prev-class="'prev-item'"
        :prev-link-class="'page-link'"
        :next-class="'next-item'"
        :next-link-class="'page-link'"
        :break-view-class="'break-view'"
        :break-view-link-class="'break-view-link'">
      </Paginate>
    </nav>
  </div>
</template>
<script>
import Paginate from 'vuejs-paginate'

export default {
  components: {
    Paginate
  },
  data: function() {
    return {
      pageNo: this.currentPage,
    }
  },
  props: {
    showPaginate: {
      type: Boolean
    },
    currentPage: {
      type: Number
    },
    totalPages: {
      type: Number
    },
    loadObjects: {
      type: Function
    }
  },
  watch: {
    currentPage: function(value) {
      this.pageNo = value
    }
  },
}
</script>
