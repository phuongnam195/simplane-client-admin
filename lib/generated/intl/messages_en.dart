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

  static String m0(count) => "${count} tickets left";

  static String m1(flightCode) => "Booking for flight ${flightCode}";

  static String m2(ticketClass) => "${ticketClass}\'s seat";

  static String m3(minDuration) =>
      "Flight duration must be at least ${minDuration} minutes!";

  static String m4(flightCode) => "Flight ${flightCode}";

  static String m5(min, max) =>
      "At intermediate airport, stop duration must belong to [${min}, ${max}]!";

  static String m6(name) => "${name} class\'s information";

  static String m7(fee) =>
      "The return fee is ${fee}. Do you want to proceed with the return?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_airport": MessageLookupByLibrary.simpleMessage("Add airport"),
        "add_airport_successfully": MessageLookupByLibrary.simpleMessage(
            "Add new airport successfully!"),
        "add_flight_successfully":
            MessageLookupByLibrary.simpleMessage("Add flight successfully!"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "agree": MessageLookupByLibrary.simpleMessage("Agree"),
        "airport": MessageLookupByLibrary.simpleMessage("Airport"),
        "airport_info_update":
            MessageLookupByLibrary.simpleMessage("Airport information update"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "annual_revenue_report":
            MessageLookupByLibrary.simpleMessage("Annual Revenue Report"),
        "app_name": MessageLookupByLibrary.simpleMessage("Simplane"),
        "approved_time":
            MessageLookupByLibrary.simpleMessage("Time of approving"),
        "arrival_airport":
            MessageLookupByLibrary.simpleMessage("Arrival airport"),
        "avail_ticket_count": m0,
        "booked_time": MessageLookupByLibrary.simpleMessage("Time of booking"),
        "booking": MessageLookupByLibrary.simpleMessage("Booking"),
        "booking_successfully":
            MessageLookupByLibrary.simpleMessage("Successfully booking!"),
        "booking_title": m1,
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "class_seat_count": m2,
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_airport_successfully": MessageLookupByLibrary.simpleMessage(
            "Delete airport successfully!"),
        "delete_flight": MessageLookupByLibrary.simpleMessage("Delete flight"),
        "delete_flight_confirm": MessageLookupByLibrary.simpleMessage(
            "Are you sure to delete this flight?"),
        "delete_staff": MessageLookupByLibrary.simpleMessage("Delete staff"),
        "delete_staff_confirm": MessageLookupByLibrary.simpleMessage(
            "Are you sure to delete this staff?"),
        "departed": MessageLookupByLibrary.simpleMessage("Departed"),
        "departure_airport":
            MessageLookupByLibrary.simpleMessage("Departure airport"),
        "email_address": MessageLookupByLibrary.simpleMessage("Email address"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage(
            "Cannot connect to server, please check your connection and try again!"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Connection timeout. Please try again!"),
        "first_name": MessageLookupByLibrary.simpleMessage("First name"),
        "flight_code": MessageLookupByLibrary.simpleMessage("Flight code"),
        "flight_count":
            MessageLookupByLibrary.simpleMessage("Number of flights"),
        "flight_date": MessageLookupByLibrary.simpleMessage("Flight date"),
        "flight_datetime": MessageLookupByLibrary.simpleMessage("Date/time"),
        "flight_duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "flight_duration_least": m3,
        "flight_schedule":
            MessageLookupByLibrary.simpleMessage("Flight schedule"),
        "flight_search_hint":
            MessageLookupByLibrary.simpleMessage("Flight code, airport,..."),
        "flight_title": m4,
        "from_airport": MessageLookupByLibrary.simpleMessage("From"),
        "fullname": MessageLookupByLibrary.simpleMessage("Full name"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity_number":
            MessageLookupByLibrary.simpleMessage("Identity number"),
        "intermediate_airport":
            MessageLookupByLibrary.simpleMessage("Intermediate airport"),
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "languageCode": MessageLookupByLibrary.simpleMessage("en"),
        "last_name": MessageLookupByLibrary.simpleMessage("Last name"),
        "latest_time_booking": MessageLookupByLibrary.simpleMessage(
            "Latest time when booking (before departure)"),
        "latest_time_cancel_booking": MessageLookupByLibrary.simpleMessage(
            "Latest time when returning (before departure)"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "max_middle_airport": MessageLookupByLibrary.simpleMessage(
            "Maximum number of intermediate airports"),
        "maximum": MessageLookupByLibrary.simpleMessage("Maximum"),
        "min_flight_duration":
            MessageLookupByLibrary.simpleMessage("Minimum flight duration"),
        "minimum": MessageLookupByLibrary.simpleMessage("Minimum"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "new_flight": MessageLookupByLibrary.simpleMessage("New flight"),
        "no_data": MessageLookupByLibrary.simpleMessage("No data"),
        "not_departed": MessageLookupByLibrary.simpleMessage("Not departed"),
        "not_empty": MessageLookupByLibrary.simpleMessage("Cannot be empty!"),
        "passenger": MessageLookupByLibrary.simpleMessage("Passenger"),
        "passenger_info":
            MessageLookupByLibrary.simpleMessage("Passenger\'s info"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone number"),
        "pick_duration":
            MessageLookupByLibrary.simpleMessage("Pick a duration"),
        "pick_ticket_class":
            MessageLookupByLibrary.simpleMessage("Pick ticket class: "),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "report": MessageLookupByLibrary.simpleMessage("Report"),
        "return_ticket": MessageLookupByLibrary.simpleMessage("Return ticket"),
        "returnable": MessageLookupByLibrary.simpleMessage("Returnable"),
        "retype_password":
            MessageLookupByLibrary.simpleMessage("Retype password"),
        "retype_password_not_match": MessageLookupByLibrary.simpleMessage(
            "Retype password does not match!"),
        "revenue": MessageLookupByLibrary.simpleMessage("Revenue"),
        "rule": MessageLookupByLibrary.simpleMessage("Rule"),
        "rule_updated_successfully":
            MessageLookupByLibrary.simpleMessage("Rule updated successfully!"),
        "seat_amount": MessageLookupByLibrary.simpleMessage("Seat amount"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign in"),
        "staff": MessageLookupByLibrary.simpleMessage("Staff"),
        "staff_search_hint": MessageLookupByLibrary.simpleMessage(
            "Staff\'s ID, username, fullname,..."),
        "stop_duration": MessageLookupByLibrary.simpleMessage("Stop duration"),
        "stop_duration_condition": m5,
        "ticket": MessageLookupByLibrary.simpleMessage("Ticket"),
        "ticket_class": MessageLookupByLibrary.simpleMessage("Ticket class"),
        "ticket_class_info": m6,
        "ticket_code": MessageLookupByLibrary.simpleMessage("Ticket code"),
        "ticket_count":
            MessageLookupByLibrary.simpleMessage("Number of tickets"),
        "ticket_return_confirm": m7,
        "ticket_return_not_suitable": MessageLookupByLibrary.simpleMessage(
            "Sorry! This ticket class is not returnable!"),
        "ticket_return_overdued": MessageLookupByLibrary.simpleMessage(
            "Sorry! Ticket return overdued."),
        "ticket_returned_successfully": MessageLookupByLibrary.simpleMessage(
            "The ticket is returned successfully!"),
        "to_airport": MessageLookupByLibrary.simpleMessage("To"),
        "unknown_error": MessageLookupByLibrary.simpleMessage(
            "Unknown error, please try again!"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "update_airport_successfully": MessageLookupByLibrary.simpleMessage(
            "Update airport successfully!"),
        "username": MessageLookupByLibrary.simpleMessage("Username")
      };
}
