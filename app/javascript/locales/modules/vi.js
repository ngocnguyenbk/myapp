const messages = {
  vi: {
    user: {
      no: 'STT',
      new_user: 'Thêm khách hàng mới',
      add_user: 'Thêm',
      delete: 'Xóa khách hàng',
      first_name: 'Họ và tên đệm',
      last_name: 'Tên',
      email: 'Email',
      phone: 'Số điện thoại',
      birthday: 'Ngày sinh',
      identity_card: 'CMND',
      room_number: 'Số phòng',
      select_room: 'Chọn phòng',
      close: 'Đóng',
      submit: 'Lưu lại',
      back: 'Trở về',
      save_change: 'Lưu thay đổi',
      edit_user: 'Chỉnh sửa',
      delete_user: 'Xóa khách hàng',
      user_id: 'Mã KH',
      created_at: 'Ngày tạo',
      edit_or_delete: 'Sửa / Xóa',
      active: 'Online',
      self: 'Khách hàng',
      deleted: 'Đã xóa!',
      info: 'Thông tin',
      errors: 'Lỗi',
      import_user: 'Nhập hàng loạt',
      not_errors: 'Không lỗi',
      confirmation: {
        perform_delete_user: 'Bạn có muốn xóa khách hàng ',
        yes: 'Có',
        close: 'Đóng',
      },
    },
    floor: {
      self: 'Tầng',
      edit_room: 'Sửa thông tin phòng',
      room_number: 'Số phòng',
      room_area: 'Diện tích(m2)',
      room_holder: 'Chủ phòng',
      select_holder: 'Chọn chủ phòng',
      room_status: 'Trạng thái',
      close: 'Đóng',
      submit: 'Lưu lại',
      back: 'Trở về',
      save_change: 'Lưu thay đổi',
      hired: 'Đã thuê',
      empty: 'Còn trống',
      deposited: 'Đã đặt cọc',
    },
    contract: {
      contract_id: 'Mã hợp đồng',
      holder_name: 'Chủ phòng',
      room_number: 'Số phòng',
      room_price: 'Giá phòng',
      deposited_money: 'Số tiền cọc',
      start_date: 'Ngày bắt đầu',
      end_date: 'Ngày kết thúc',
      extend: 'Gia hạn',
      details: 'Chi tiết',
      terminate: 'Hủy',
      status: 'Trạng thái',
      detail_contract: 'Chi tiết hợp đồng',
      id: 'ID',
      month_rented: 'Số tháng đã thuê',
      month_remain: 'Số tháng còn lại',
      total_money: 'Tổng tiền',
      close: 'Đóng',
      new_contract: 'Tạo mới',
      select_holder: 'Chủ phòng',
      select_room: 'Chọn phòng',
      deposited: 'Đã cọc',
      submit: 'Lưu lại',
      number_of_month: 'Số tháng',
      or_input: 'hoặc nhập',
      back: 'Trở về',
      extend_contract: 'Gia hạn hợp đồng số',
      confirm: 'Xác nhận',
      terminate_contract: 'Chấm dứt hợp đồng',
      confirmation: {
        perform_terminate_contract: 'Bạn có muốn chấm dứt hợp đồng',
        yes: 'Có',
        close: 'Không',
      },
      defaultMonth: {
        month: '{count} tháng',
      },
    },
    invoice: {
      room: 'Phòng',
      deposited: 'Đặt cọc',
      price: 'Tiền phòng',
      electric: 'Điện',
      water: 'Nước',
      internet: 'Internet',
      num: 'Số lượng',
      service: 'Phí dịch vụ',
      total: 'Tổng',
      reduce: 'Giảm trừ',
      holder: 'Chủ phòng',
      begin_number: 'Số đầu',
      end_number: 'Số cuối',
      use: 'Sử  dụng',
      into_money: 'Thành tiền',
      note: 'Ghi chú',
      not_contract: 'Không có hợp đồng',
      check_form: 'Kiểm tra',
      submit_form: 'Lưu lại',
      error_msg: 'Vui lòng kiểm tra lại dữ liệu phòng {room}',
      success_msg: 'Dữ liệu thỏa mãn',
      choose_room: 'Vui lòng chọn phòng',
      batch_create: 'Tạo mới hàng loạt',
      invoice_id: 'Mã hóa đơn',
      month: 'Tháng',
      total_income: 'Tổng thu',
      export_print: 'Xuất/In',
      no: 'TT',
      print_title: 'THÔNG BÁO TIỀN THUÊ PHÒNG',
      room_no: 'Phòng số',
      service: 'Dịch vụ',
      unit: 'Đơn vị',
      qty: 'SL',
      unit_price: 'Đơn giá',
      room_price: 'Tiền thuê phòng',
      ele_price: 'Chi phí điện',
      wat_price: 'Chi phí nước',
      paf_price: 'Chi phí gửi xe',
      int_price: 'Chi phí internet',
      ser_price: 'Phí dịch vụ',
      total_1: 'Cộng (1)',
      reduce_or_increase: 'Chi phí giảm trừ hoặc tăng thêm (nếu có)',
      reduce_1: 'Giảm trừ',
      total_2: 'Cộng (2)',
      print_total: 'Tổng cộng (1-2)',
      num_month: '1',
      from_to: '(Từ số {begin} đến số {end})',
      payment_deadline: '- Thời hạn nộp tiền thuê phòng: từ ngày 01-03 hàng tháng (quý)',
      transfer_infor: '- Thông tin chuyển khoản:',
      account_name: '+ Tên tài khoản: Trương Văn Cường',
      account_number: '+ Số TK: 19036705038010. Techcombank - Chi nhánh Ba Đình',
      transfer_content: '+ Nội dung chuyển khoản:',
      content: 'Phòng số .......... Tên khách thuê .......... Nộp tiền nhà tháng ..........',
      date_time: 'Hà Nội, ngày .......... tháng .......... năm ..........',
      payer: 'Người nộp',
      receiptor: 'Người thu',
      print: 'In hóa đơn',
      copy: 'Sao chép',
      copy_success: 'Sao chép thành công',
      generate_success: 'Tạo ảnh thành công',
      add_invoice: 'Tạo hóa đơn',
      new_invoice: 'Tạo hóa đơn mới',
      room_number: 'Phòng số',
      room_price: 'Giá phòng',
      day_used_per_month: 'Ngày sử dụng trong tháng',
      electric_start: 'Số điện đầu kì',
      electric_end: 'Số điện cuối kì',
      water_start: 'Số nước đầu kì',
      water_end: 'Số nước cuối kì',
      unit_price_internet: 'Đơn giá internet',
      unit_price_parking_fee: 'Phí gửi xe',
      quantity_parking: 'Số lượng xe',
      unit_price_service_fee: 'Phí dịch vụ',
      reduce: 'Giảm trừ',
      total: 'Tổng tiền',
      select_room: 'Chọn phòng',
      details: 'Chi tiết',
      close: 'Đóng',
      detail_invoice: 'Chi tiết hóa đơn',
      input_month: 'Vui lòng nhập tháng',
      print_x: 'In',
      download: 'Tải xuống',
      edit_or_delete: 'Sửa / Xóa',
      edit_invoice: 'Sửa hóa đơn',
      submit: 'Lưu lại',
      back: 'Trở về',
      save_change: 'Lưu thay đổi',
      self: 'Hóa đơn',
      info: 'Thông tin',
      delete_invoice: 'Xóa hóa đơn',
      deleted: 'Đã xóa',
      confirmation: {
        perform_delete_invoice: 'Bạn có muốn xóa hóa đơn',
        yes: 'Có',
        close: 'Đóng',
      },
    },
    upload_file: {
      import_file: 'Nhập hàng loạt',
      close: 'Đóng',
      upload: 'Upload',
    },
    flash: {
      success: 'Thành công!',
      unsuccess: 'Không thành công!',
    },
  },
};

export default messages;
