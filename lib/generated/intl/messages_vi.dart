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

  static String m2(ticketClass) => "${ticketClass}\'s chỗ";

  static String m3(flightCode) => "Chuyến bay ${flightCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "annual_revenue_report":
            MessageLookupByLibrary.simpleMessage("Báo cáo doanh thu hàng năm"),
        "app_name": MessageLookupByLibrary.simpleMessage("Simplane"),
        "approved_time":
            MessageLookupByLibrary.simpleMessage("Thời gian phê duyệt"),
        "avail_ticket_count": m0,
        "booked_time": MessageLookupByLibrary.simpleMessage("Thời gian đặt vé"),
        "booking": MessageLookupByLibrary.simpleMessage("Đặt vé"),
        "booking_title": m1,
        "class_seat_count": m2,
        "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage(
            "Không thể kết nối với máy chủ, vui lòng kiểm tra kết nối của bạn và thử lại!"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Hết thời gian kết nối. Vui lòng thử lại!"),
        "flight_code": MessageLookupByLibrary.simpleMessage("Mã chuyến bay"),
        "flight_count":
            MessageLookupByLibrary.simpleMessage("Số lượng chuyến bay"),
        "flight_date": MessageLookupByLibrary.simpleMessage("Ngày bay"),
        "flight_datetime": MessageLookupByLibrary.simpleMessage("Ngày/giờ"),
        "flight_duration":
            MessageLookupByLibrary.simpleMessage("Thời gian bay"),
        "flight_schedule":
            MessageLookupByLibrary.simpleMessage("Lịch trình chuyến bay"),
        "flight_search_hint":
            MessageLookupByLibrary.simpleMessage("Mã chuyến bay, sân bay,..."),
        "flight_title": m3,
        "from_airport": MessageLookupByLibrary.simpleMessage("Từ"),
        "fullname": MessageLookupByLibrary.simpleMessage("Họ và tên"),
        "hahahaha": MessageLookupByLibrary.simpleMessage("hahahaha"),
        "identity_number": MessageLookupByLibrary.simpleMessage("Số CCCD"),
        "intermediate_airport":
            MessageLookupByLibrary.simpleMessage("Sân bay trung gian"),
        "is_sold": MessageLookupByLibrary.simpleMessage("Đã bán"),
        "languageCode": MessageLookupByLibrary.simpleMessage("vi"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "month": MessageLookupByLibrary.simpleMessage("Tháng"),
        "no_data": MessageLookupByLibrary.simpleMessage("Không có dữ liệu"),
        "not_empty":
            MessageLookupByLibrary.simpleMessage("Không được để trống!"),
        "not_sold": MessageLookupByLibrary.simpleMessage("Chưa bán"),
        "passenger": MessageLookupByLibrary.simpleMessage("Hành khách"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "pending": MessageLookupByLibrary.simpleMessage("Chờ xét duyệt"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "pick_duration":
            MessageLookupByLibrary.simpleMessage("Chọn khoảng thời gian"),
        "pick_ticket_class":
            MessageLookupByLibrary.simpleMessage("Chọn hạng vé: "),
        "price": MessageLookupByLibrary.simpleMessage("Giá"),
        "register": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "report": MessageLookupByLibrary.simpleMessage("Báo cáo"),
        "retype_password":
            MessageLookupByLibrary.simpleMessage("Nhập lại mật khẩu"),
        "retype_password_not_match": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu nhập lại không khớp!"),
        "revenue": MessageLookupByLibrary.simpleMessage("Doanh thu"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "stop_duration": MessageLookupByLibrary.simpleMessage("Thời gian dừng"),
        "ticket": MessageLookupByLibrary.simpleMessage("Vé"),
        "ticket_class": MessageLookupByLibrary.simpleMessage("Hạng vé"),
        "ticket_code": MessageLookupByLibrary.simpleMessage("Mã vé"),
        "ticket_count": MessageLookupByLibrary.simpleMessage("Số lượng vé"),
        "to_airport": MessageLookupByLibrary.simpleMessage("Đến"),
        "unknown_error": MessageLookupByLibrary.simpleMessage(
            "Lỗi không xác định, vui lòng thử lại!"),
        "username": MessageLookupByLibrary.simpleMessage("Tên đăng nhập")
      };
}
