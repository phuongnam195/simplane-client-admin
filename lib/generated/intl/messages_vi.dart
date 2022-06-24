// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(count) => "còn ${count} vé";

  static String m1(flightCode) => "Đặt vé cho chuyến bay ${flightCode}";

  static String m2(ticketClass) => "Số vé ${ticketClass}";

  static String m3(minDuration) =>
      "Thời lượng chuyến bay phải ít nhất là ${minDuration} phút!";

  static String m4(flightCode) => "Chuyến bay ${flightCode}";

  static String m5(min, max) =>
      "Tại sân bay trung gian, thời gian dừng phải thuộc khoảng [${min}, ${max}] phút!";

  static String m6(name) => "Thông tin hạng vé ${name}";

  static String m7(fee) => "Phí hoàn vé là ${fee}. Bạn có muốn tiếp tục không?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_airport": MessageLookupByLibrary.simpleMessage("Thêm sân bay"),
        "add_airport_successfully":
            MessageLookupByLibrary.simpleMessage("Thêm sân bay thành công!"),
        "add_flight_successfully":
            MessageLookupByLibrary.simpleMessage("Thêm chuyến bay thành công!"),
        "address": MessageLookupByLibrary.simpleMessage("Địa chỉ"),
        "agree": MessageLookupByLibrary.simpleMessage("Đồng ý"),
        "airport": MessageLookupByLibrary.simpleMessage("Sân bay"),
        "airport_info_update":
            MessageLookupByLibrary.simpleMessage("Cập nhật thông tin sân bay"),
        "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "annual_revenue_report":
            MessageLookupByLibrary.simpleMessage("Báo cáo doanh thu hằng năm"),
        "app_name": MessageLookupByLibrary.simpleMessage("Simplane"),
        "approved_time":
            MessageLookupByLibrary.simpleMessage("Thời gian phê duyệt"),
        "arrival_airport": MessageLookupByLibrary.simpleMessage("Sân bay đến"),
        "avail_ticket_count": m0,
        "booked_time": MessageLookupByLibrary.simpleMessage("Thời gian đặt vé"),
        "booking": MessageLookupByLibrary.simpleMessage("Đặt vé"),
        "booking_successfully":
            MessageLookupByLibrary.simpleMessage("Đặt vé thành công!"),
        "booking_title": m1,
        "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
        "class_seat_count": m2,
        "code": MessageLookupByLibrary.simpleMessage("Mã"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
        "delete_airport_successfully":
            MessageLookupByLibrary.simpleMessage("Xóa sân bay thành công!"),
        "delete_flight": MessageLookupByLibrary.simpleMessage("Xóa chuyến bay"),
        "delete_flight_confirm": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn xóa chuyến bay này không?"),
        "delete_staff": MessageLookupByLibrary.simpleMessage("Xóa nhân viên"),
        "delete_staff_confirm": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn xóa nhân viên này không?"),
        "departed": MessageLookupByLibrary.simpleMessage("Đã khởi hành"),
        "departure_airport": MessageLookupByLibrary.simpleMessage("Sân bay đi"),
        "email_address": MessageLookupByLibrary.simpleMessage("Địa chỉ email"),
        "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage(
            "Không thể kết nối với máy chủ, vui lòng kiểm tra kết nối của bạn và thử lại!"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Hết thời gian kết nối. Vui lòng thử lại!"),
        "first_name": MessageLookupByLibrary.simpleMessage("Họ và tên đêm"),
        "flight_code": MessageLookupByLibrary.simpleMessage("Mã chuyến bay"),
        "flight_count":
            MessageLookupByLibrary.simpleMessage("Số lượng chuyến bay"),
        "flight_date": MessageLookupByLibrary.simpleMessage("Ngày bay"),
        "flight_datetime": MessageLookupByLibrary.simpleMessage("Ngày/giờ"),
        "flight_duration":
            MessageLookupByLibrary.simpleMessage("Thời gian bay"),
        "flight_duration_least": m3,
        "flight_schedule":
            MessageLookupByLibrary.simpleMessage("Lịch trình chuyến bay"),
        "flight_search_hint":
            MessageLookupByLibrary.simpleMessage("Mã chuyến bay, sân bay,..."),
        "flight_title": m4,
        "from_airport": MessageLookupByLibrary.simpleMessage("Từ"),
        "fullname": MessageLookupByLibrary.simpleMessage("Họ và tên"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity_number": MessageLookupByLibrary.simpleMessage("Số CCCD"),
        "intermediate_airport":
            MessageLookupByLibrary.simpleMessage("Sân bay trung gian"),
        "language": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "languageCode": MessageLookupByLibrary.simpleMessage("vi"),
        "last_name": MessageLookupByLibrary.simpleMessage("Tên"),
        "latest_time_booking": MessageLookupByLibrary.simpleMessage(
            "Thời gian chậm nhất khi đặt vé"),
        "latest_time_cancel_booking": MessageLookupByLibrary.simpleMessage(
            "Thời gian chậm nhất khi hủy đặt vé"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "max_middle_airport": MessageLookupByLibrary.simpleMessage(
            "Số lượng sân bay trung gian tối đa"),
        "maximum": MessageLookupByLibrary.simpleMessage("Tối đa"),
        "min_flight_duration":
            MessageLookupByLibrary.simpleMessage("Thời lượng bay tối thiểu"),
        "minimum": MessageLookupByLibrary.simpleMessage("Tối thiểu"),
        "month": MessageLookupByLibrary.simpleMessage("Tháng"),
        "name": MessageLookupByLibrary.simpleMessage("Tên"),
        "new_flight":
            MessageLookupByLibrary.simpleMessage("Thêm chuyến bay mới"),
        "no_data": MessageLookupByLibrary.simpleMessage("Không có dữ liệu"),
        "not_departed": MessageLookupByLibrary.simpleMessage("Chưa khởi hành"),
        "not_empty":
            MessageLookupByLibrary.simpleMessage("Không được để trống!"),
        "passenger": MessageLookupByLibrary.simpleMessage("Hành khách"),
        "passenger_info":
            MessageLookupByLibrary.simpleMessage("Thông tin hành khách"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "pick_duration":
            MessageLookupByLibrary.simpleMessage("Chọn khoảng thời gian"),
        "pick_ticket_class":
            MessageLookupByLibrary.simpleMessage("Chọn hạng vé: "),
        "price": MessageLookupByLibrary.simpleMessage("Giá"),
        "register": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "report": MessageLookupByLibrary.simpleMessage("Báo cáo"),
        "return_ticket": MessageLookupByLibrary.simpleMessage("Hoàn vé"),
        "returnable": MessageLookupByLibrary.simpleMessage("Có thể hoàn"),
        "retype_password":
            MessageLookupByLibrary.simpleMessage("Nhập lại mật khẩu"),
        "retype_password_not_match": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu nhập lại không khớp!"),
        "revenue": MessageLookupByLibrary.simpleMessage("Doanh thu"),
        "rule": MessageLookupByLibrary.simpleMessage("Quy định"),
        "rule_updated_successfully": MessageLookupByLibrary.simpleMessage(
            "Đã cập nhật quy định thành công!"),
        "seat_amount": MessageLookupByLibrary.simpleMessage("Số ghế"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "staff": MessageLookupByLibrary.simpleMessage("Nhân viên"),
        "stop_duration": MessageLookupByLibrary.simpleMessage("Thời gian dừng"),
        "stop_duration_condition": m5,
        "ticket": MessageLookupByLibrary.simpleMessage("Vé"),
        "ticket_class": MessageLookupByLibrary.simpleMessage("Hạng vé"),
        "ticket_class_info": m6,
        "ticket_code": MessageLookupByLibrary.simpleMessage("Mã vé"),
        "ticket_count": MessageLookupByLibrary.simpleMessage("Số lượng vé"),
        "ticket_return_confirm": m7,
        "ticket_return_not_suitable": MessageLookupByLibrary.simpleMessage(
            "Xin lỗi! Hạng vé này không thể hoàn lại."),
        "ticket_return_overdued": MessageLookupByLibrary.simpleMessage(
            "Xin lỗi! Vé này đã quá hạn hoàn lại."),
        "ticket_returned_successfully":
            MessageLookupByLibrary.simpleMessage("Vé đã được hoàn thành công!"),
        "to_airport": MessageLookupByLibrary.simpleMessage("Đến"),
        "unknown_error": MessageLookupByLibrary.simpleMessage(
            "Lỗi không xác định, vui lòng thử lại!"),
        "update": MessageLookupByLibrary.simpleMessage("Cập nhật"),
        "update_airport_successfully": MessageLookupByLibrary.simpleMessage(
            "Cập nhật sân bay thành công!"),
        "username": MessageLookupByLibrary.simpleMessage("Tên đăng nhập")
      };
}
