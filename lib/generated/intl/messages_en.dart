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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Simplane"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage(
            "Cannot connect to server, please check your connection and try again!"),
        "error_timeout": MessageLookupByLibrary.simpleMessage(
            "Connection timeout. Please try again!"),
        "fullname": MessageLookupByLibrary.simpleMessage("Full name"),
        "hahahaha": MessageLookupByLibrary.simpleMessage("hahahaha"),
        "no_data": MessageLookupByLibrary.simpleMessage("No data"),
        "not_empty": MessageLookupByLibrary.simpleMessage("Cannot be empty!"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "retype_password":
            MessageLookupByLibrary.simpleMessage("Retype password"),
        "retype_password_not_match": MessageLookupByLibrary.simpleMessage(
            "Retype password does not match!"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign in"),
        "unknown_error": MessageLookupByLibrary.simpleMessage(
            "Unknown error, please try again!"),
        "username": MessageLookupByLibrary.simpleMessage("Username")
      };
}
