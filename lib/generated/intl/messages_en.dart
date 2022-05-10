// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(ticketClass) => "${ticketClass}\'s seat";

  static String m1(flightCode) => "Flight ${flightCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Simplane"),
        "booked_time": MessageLookupByLibrary.simpleMessage("Time of booking"),
        "class_seat_count": m0,
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage(
            "Cannot connect to server, please check your connection and try again!"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Connection timeout. Please try again!"),
        "flight_code": MessageLookupByLibrary.simpleMessage("Flight code"),
        "flight_date": MessageLookupByLibrary.simpleMessage("Flight date"),
        "flight_datetime": MessageLookupByLibrary.simpleMessage("Date/time"),
        "flight_duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "flight_schedule":
            MessageLookupByLibrary.simpleMessage("Flight schedule"),
        "flight_search_hint":
            MessageLookupByLibrary.simpleMessage("Flight code, airport,..."),
        "flight_title": m1,
        "from_airport": MessageLookupByLibrary.simpleMessage("From"),
        "fullname": MessageLookupByLibrary.simpleMessage("Full name"),
        "hahahaha": MessageLookupByLibrary.simpleMessage("hahahaha"),
        "identity_number": MessageLookupByLibrary.simpleMessage("Identity"),
        "intermediate_airport":
            MessageLookupByLibrary.simpleMessage("Intermediate airport"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "no_data": MessageLookupByLibrary.simpleMessage("No data"),
        "not_empty": MessageLookupByLibrary.simpleMessage("Cannot be empty!"),
        "passenger": MessageLookupByLibrary.simpleMessage("Passenger"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone number"),
        "pick_duration":
            MessageLookupByLibrary.simpleMessage("Pick a duration"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "report": MessageLookupByLibrary.simpleMessage("Report"),
        "retype_password":
            MessageLookupByLibrary.simpleMessage("Retype password"),
        "retype_password_not_match": MessageLookupByLibrary.simpleMessage(
            "Retype password does not match!"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign in"),
        "stop_duration": MessageLookupByLibrary.simpleMessage("Stop duration"),
        "ticket": MessageLookupByLibrary.simpleMessage("Ticket"),
        "ticket_class": MessageLookupByLibrary.simpleMessage("Ticket class"),
        "ticket_code": MessageLookupByLibrary.simpleMessage("Ticket code"),
        "to_airport": MessageLookupByLibrary.simpleMessage("To"),
        "unknown_error": MessageLookupByLibrary.simpleMessage(
            "Unknown error, please try again!"),
        "username": MessageLookupByLibrary.simpleMessage("Username")
      };
}
