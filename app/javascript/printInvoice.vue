<template>
  <div id="app" class="w-40 ml-auto mr-auto">
    <FlashMessage :position="'right top'"></FlashMessage>
    <div ref="invoice" class="p-4">
      <div class="text-center d-flex flex-column mb-4">
        <strong>{{ $t('invoice.print_title') }}</strong>
        <span>{{ $t('invoice.month') + ' ' + invoice.month }} - {{ $t('invoice.room_no') + ' ' + invoice.room_number }}</span>
      </div>
      <table class="table table-multi-body table-bordered">
        <thead class="table-header">
          <tr class="table-head text-center">
            <td class="w-5">{{ $t('invoice.no') }}</td>
            <td class="w-15">{{ $t('invoice.service') }}</td>
            <td class="w-5">{{ $t('invoice.unit') }}</td>
            <td class="w-5">{{ $t('invoice.qty') }}</td>
            <td class="w-10">{{ $t('invoice.unit_price') }}</td>
            <td class="w-10">{{ $t('invoice.into_money') }}</td>
            <td class="w-10">{{ $t('invoice.note') }}</td>
          </tr>
        </thead>
        <tbody class="text-center">
          <tr class="row_room">
            <td>1</td>
            <td class="text-left">{{ $t('invoice.room_price') }}</td>
            <td>{{ $t('invoice.month') }}</td>
            <td>{{ $t('invoice.num_month') }}</td>
            <td>{{ invoice.room_price | formatNumber }}</td>
            <td>{{ invoice.total_room_price | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_electric">
            <td>2</td>
            <td class="text-left">
              <span>{{ $t('invoice.ele_price') }}</span><br>
              <span>{{ $t('invoice.from_to', { begin: invoice.begin_number_ele, end: invoice.end_number_ele }) }}</span>
            </td>
            <td>{{ invoice.unit_electric }}</td>
            <td>{{ invoice.qty_electric | formatNumber }}</td>
            <td>{{ invoice.unit_price_electric | formatNumber }}</td>
            <td>{{ invoice.total_electric | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_water">
            <td>3</td>
            <td class="text-left">
              <span>{{ $t('invoice.wat_price') }}</span><br>
              <span>{{ $t('invoice.from_to', { begin: invoice.begin_number_wat, end: invoice.end_number_wat }) }}</span>
            <td>{{ invoice.unit_water }}</td>
            <td>{{ invoice.qty_water | formatNumber }}</td>
            <td>{{ invoice.unit_price_water | formatNumber }}</td>
            <td>{{ invoice.total_water | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_parking_fee">
            <td>4</td>
            <td class="text-left">{{ $t('invoice.paf_price') }}</td>
            <td>{{ invoice.unit_parking_fee }}</td>
            <td>{{ invoice.qty_parking_fee | formatNumber }}</td>
            <td>{{ invoice.unit_price_parking_fee | formatNumber }}</td>
            <td>{{ invoice.total_parking_fee | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_internet">
            <td>5</td>
            <td class="text-left">{{ $t('invoice.int_price') }}</td>
            <td>{{ invoice.unit_internet }}</td>
            <td>{{ invoice.qty_internet | formatNumber }}</td>
            <td>{{ invoice.unit_price_internet | formatNumber }}</td>
            <td>{{ invoice.total_internet | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_service">
            <td>6</td>
            <td class="text-left">{{ $t('invoice.ser_price') }}</td>
            <td>{{ invoice.unit_service }}</td>
            <td>{{ invoice.qty_service | formatNumber }}</td>
            <td>{{ invoice.unit_price_service | formatNumber }}</td>
            <td>{{ invoice.total_service | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_total_1">
            <td></td>
            <td class="font-weight-bold">{{ $t('invoice.total_1') }}</td>
            <td></td>
            <td></td>
            <td></td>
            <td>{{ invoice.total_cost | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_reduce">
            <td></td>
            <td colspan="3" class="text-left">{{ $t('invoice.reduce_or_increase') }}</td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr class="row_reduce_1">
            <td>1</td>
            <td class="text-left">{{ $t('invoice.reduce_1') }}</td>
            <td></td>
            <td></td>
            <td></td>
            <td>{{ invoice.reduce | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_reduce_2">
            <td>2</td>
            <td class="text-left"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr class="row_reduce_3">
            <td>3</td>
            <td class="text-left"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr class="row_total_2">
            <td></td>
            <td class="font-weight-bold">{{ $t('invoice.total_2') }}</td>
            <td></td>
            <td></td>
            <td></td>
            <td>{{ invoice.total_reduce | formatNumber }}</td>
            <td></td>
          </tr>
          <tr class="row_total">
            <td></td>
            <td colspan="2" class="font-weight-bold">{{ $t('invoice.print_total') }}</td>
            <td></td>
            <td></td>
            <td>{{ invoice.total_revenue | formatNumber }}</td>
            <td></td>
          </tr>
        </tbody>
      </table><br>
      <div class="d-flex flex-column">
        <span>{{ $t('invoice.payment_deadline') }}</span>
        <span>{{ $t('invoice.transfer_infor') }}</span>
        <span class="text-indent">{{ $t('invoice.account_name') }}</span>
        <span class="text-indent">{{ $t('invoice.account_number') }}</span>
        <span class="text-indent">{{ $t('invoice.transfer_content') }}</span>
        <span class="text-indent-a">{{ $t('invoice.content') }}</span><br>
        <span class="ml-auto">{{ $t('invoice.date_time') }}</span><br>
        <div class="col-md-12 row mb-5">
          <span class="col-md-6 font-weight-bold text-center">{{ $t('invoice.payer') }}</span>
          <span class="col-md-6 font-weight-bold text-center">{{ $t('invoice.receiptor') }}</span>
        </div>
      </div>
    </div>
    <div class="footer mb-5">
      <button class="btn btn-danger float-right" type="button" @click="printInvoice">
        {{ $t('invoice.print') }}
      </button>
      <button class="btn btn-primary float-right mr-1" type="button" @click="copyInvoice">
        {{ $t("invoice.copy") }}
      </button>
    </div>
  </div>
</template>

<script>
import axios from 'api/axios.js'
import show_flash_mixins from 'mixins/show_flash'

export default {
  data: function() {
    return {
      invoice: {},
      flashMsg: this.$t('invoice.copy_success')
    }
  },
  created: function() {
    const self = this
    axios.get(`/invoices/${invoiceID}.json`, {}
    ).then(function(response) {
      self.invoice = response.data.invoice
    }).catch(function(error) {
      console.log(error.response)
    })
  },
  methods: {
    printInvoice: function() {
      const prtHtml = this.$refs.invoice.innerHTML

      let stylesHtml = ''
      for (const node of [...document.querySelectorAll('link[rel="stylesheet"], style')]) {
        stylesHtml += node.outerHTML
      }

      const WinPrint = window.open('', '', 'scrollbars=0,status=0,fullscreen=0')
      WinPrint.document.write(`<!DOCTYPE html>
                                <html>
                                  <head>
                                    ${stylesHtml}
                                  </head>
                                  <body>
                                    ${prtHtml}
                                  </body>
                                </html>`
                              )

      WinPrint.document.close()
      WinPrint.focus()
      WinPrint.print()
    },
    copyInvoice() {
      const self = this
      const node = this.$refs.invoice

      html2canvas(node, {
        scrollY: -window.scrollY,
        width: node.scrollWidth,
      }).then(function (canvas) {
        canvas.toBlob(function(blob) {
          navigator.clipboard
            .write([
              new ClipboardItem(
                Object.defineProperty({}, blob.type, {
                  value: blob,
                  enumerable: true
                })
              )
            ])
            .then(function() {
              self.show_flash(true)
            })
        })
      })
    },
  },
  mixins: [show_flash_mixins],
}
</script>

<style lang="scss" scoped>
.table-bordered {
  th, td {
    padding: 0.1rem;
    border: 1px solid #000 !important;
  }
}
.text-indent {
  text-indent: 15px;
}
.text-indent-a {
  text-indent: 30px;
}
</style>
