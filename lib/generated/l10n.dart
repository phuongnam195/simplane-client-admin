// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Simplane`
  String get app_name {
    return Intl.message(
      'Simplane',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Cannot connect to server, please check your connection and try again!`
  String get error_no_internet {
    return Intl.message(
      'Cannot connect to server, please check your connection and try again!',
      name: 'error_no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout. Please try again!`
  String get error_timeout {
    return Intl.message(
      'Connection timeout. Please try again!',
      name: 'error_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error, please try again!`
  String get unknown_error {
    return Intl.message(
      'Unknown error, please try again!',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullname {
    return Intl.message(
      'Full name',
      name: 'fullname',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Retype password`
  String get retype_password {
    return Intl.message(
      'Retype password',
      name: 'retype_password',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be empty!`
  String get not_empty {
    return Intl.message(
      'Cannot be empty!',
      name: 'not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Retype password does not match!`
  String get retype_password_not_match {
    return Intl.message(
      'Retype password does not match!',
      name: 'retype_password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Flight code`
  String get flight_code {
    return Intl.message(
      'Flight code',
      name: 'flight_code',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from_airport {
    return Intl.message(
      'From',
      name: 'from_airport',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to_airport {
    return Intl.message(
      'To',
      name: 'to_airport',
      desc: '',
      args: [],
    );
  }

  /// `Date/time`
  String get flight_datetime {
    return Intl.message(
      'Date/time',
      name: 'flight_datetime',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get flight_duration {
    return Intl.message(
      'Duration',
      name: 'flight_duration',
      desc: '',
      args: [],
    );
  }

  /// `{ticketClass}'s seat`
  String class_seat_count(String ticketClass) {
    return Intl.message(
      '$ticketClass\'s seat',
      name: 'class_seat_count',
      desc: '',
      args: [ticketClass],
    );
  }

  /// `Flight code, airport,...`
  String get flight_search_hint {
    return Intl.message(
      'Flight code, airport,...',
      name: 'flight_search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Pick a duration`
  String get pick_duration {
    return Intl.message(
      'Pick a duration',
      name: 'pick_duration',
      desc: '',
      args: [],
    );
  }

  /// `Flight {flightCode}`
  String flight_title(String flightCode) {
    return Intl.message(
      'Flight $flightCode',
      name: 'flight_title',
      desc: '',
      args: [flightCode],
    );
  }

  /// `Intermediate airport`
  String get intermediate_airport {
    return Intl.message(
      'Intermediate airport',
      name: 'intermediate_airport',
      desc: '',
      args: [],
    );
  }

  /// `Stop duration`
  String get stop_duration {
    return Intl.message(
      'Stop duration',
      name: 'stop_duration',
      desc: '',
      args: [],
    );
  }

  /// `Ticket code`
  String get ticket_code {
    return Intl.message(
      'Ticket code',
      name: 'ticket_code',
      desc: '',
      args: [],
    );
  }

  /// `Flight date`
  String get flight_date {
    return Intl.message(
      'Flight date',
      name: 'flight_date',
      desc: '',
      args: [],
    );
  }

  /// `Passenger`
  String get passenger {
    return Intl.message(
      'Passenger',
      name: 'passenger',
      desc: '',
      args: [],
    );
  }

  /// `Identity`
  String get identity_number {
    return Intl.message(
      'Identity',
      name: 'identity_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Ticket class`
  String get ticket_class {
    return Intl.message(
      'Ticket class',
      name: 'ticket_class',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Time of booking`
  String get booked_time {
    return Intl.message(
      'Time of booking',
      name: 'booked_time',
      desc: '',
      args: [],
    );
  }

  /// `Flight schedule`
  String get flight_schedule {
    return Intl.message(
      'Flight schedule',
      name: 'flight_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Ticket`
  String get ticket {
    return Intl.message(
      'Ticket',
      name: 'ticket',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `hahahaha`
  String get hahahaha {
    return Intl.message(
      'hahahaha',
      name: 'hahahaha',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
