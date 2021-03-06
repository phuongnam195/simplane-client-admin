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

  /// `en`
  String get languageCode {
    return Intl.message(
      'en',
      name: 'languageCode',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
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

  /// `Staff's ID, username, fullname,...`
  String get staff_search_hint {
    return Intl.message(
      'Staff\'s ID, username, fullname,...',
      name: 'staff_search_hint',
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

  /// `Identity number`
  String get identity_number {
    return Intl.message(
      'Identity number',
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

  /// `Time of approving`
  String get approved_time {
    return Intl.message(
      'Time of approving',
      name: 'approved_time',
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

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Returnable`
  String get returnable {
    return Intl.message(
      'Returnable',
      name: 'returnable',
      desc: '',
      args: [],
    );
  }

  /// `Departed`
  String get departed {
    return Intl.message(
      'Departed',
      name: 'departed',
      desc: '',
      args: [],
    );
  }

  /// `Not departed`
  String get not_departed {
    return Intl.message(
      'Not departed',
      name: 'not_departed',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Number of flights`
  String get flight_count {
    return Intl.message(
      'Number of flights',
      name: 'flight_count',
      desc: '',
      args: [],
    );
  }

  /// `Number of tickets`
  String get ticket_count {
    return Intl.message(
      'Number of tickets',
      name: 'ticket_count',
      desc: '',
      args: [],
    );
  }

  /// `Revenue`
  String get revenue {
    return Intl.message(
      'Revenue',
      name: 'revenue',
      desc: '',
      args: [],
    );
  }

  /// `Annual Revenue Report`
  String get annual_revenue_report {
    return Intl.message(
      'Annual Revenue Report',
      name: 'annual_revenue_report',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Booking for flight {flightCode}`
  String booking_title(String flightCode) {
    return Intl.message(
      'Booking for flight $flightCode',
      name: 'booking_title',
      desc: '',
      args: [flightCode],
    );
  }

  /// `{count} tickets left`
  String avail_ticket_count(int count) {
    return Intl.message(
      '$count tickets left',
      name: 'avail_ticket_count',
      desc: '',
      args: [count],
    );
  }

  /// `Pick ticket class: `
  String get pick_ticket_class {
    return Intl.message(
      'Pick ticket class: ',
      name: 'pick_ticket_class',
      desc: '',
      args: [],
    );
  }

  /// `Passenger's info`
  String get passenger_info {
    return Intl.message(
      'Passenger\'s info',
      name: 'passenger_info',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `New flight`
  String get new_flight {
    return Intl.message(
      'New flight',
      name: 'new_flight',
      desc: '',
      args: [],
    );
  }

  /// `Departure airport`
  String get departure_airport {
    return Intl.message(
      'Departure airport',
      name: 'departure_airport',
      desc: '',
      args: [],
    );
  }

  /// `Arrival airport`
  String get arrival_airport {
    return Intl.message(
      'Arrival airport',
      name: 'arrival_airport',
      desc: '',
      args: [],
    );
  }

  /// `{name} class's information`
  String ticket_class_info(String name) {
    return Intl.message(
      '$name class\'s information',
      name: 'ticket_class_info',
      desc: '',
      args: [name],
    );
  }

  /// `Seat amount`
  String get seat_amount {
    return Intl.message(
      'Seat amount',
      name: 'seat_amount',
      desc: '',
      args: [],
    );
  }

  /// `Add flight successfully!`
  String get add_flight_successfully {
    return Intl.message(
      'Add flight successfully!',
      name: 'add_flight_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message(
      'Staff',
      name: 'staff',
      desc: '',
      args: [],
    );
  }

  /// `Delete staff`
  String get delete_staff {
    return Intl.message(
      'Delete staff',
      name: 'delete_staff',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this staff?`
  String get delete_staff_confirm {
    return Intl.message(
      'Are you sure to delete this staff?',
      name: 'delete_staff_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Successfully booking!`
  String get booking_successfully {
    return Intl.message(
      'Successfully booking!',
      name: 'booking_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete flight`
  String get delete_flight {
    return Intl.message(
      'Delete flight',
      name: 'delete_flight',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this flight?`
  String get delete_flight_confirm {
    return Intl.message(
      'Are you sure to delete this flight?',
      name: 'delete_flight_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Airport`
  String get airport {
    return Intl.message(
      'Airport',
      name: 'airport',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Airport information update`
  String get airport_info_update {
    return Intl.message(
      'Airport information update',
      name: 'airport_info_update',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update airport successfully!`
  String get update_airport_successfully {
    return Intl.message(
      'Update airport successfully!',
      name: 'update_airport_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Add new airport successfully!`
  String get add_airport_successfully {
    return Intl.message(
      'Add new airport successfully!',
      name: 'add_airport_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete airport successfully!`
  String get delete_airport_successfully {
    return Intl.message(
      'Delete airport successfully!',
      name: 'delete_airport_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Add airport`
  String get add_airport {
    return Intl.message(
      'Add airport',
      name: 'add_airport',
      desc: '',
      args: [],
    );
  }

  /// `Return ticket`
  String get return_ticket {
    return Intl.message(
      'Return ticket',
      name: 'return_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! Ticket return overdued.`
  String get ticket_return_overdued {
    return Intl.message(
      'Sorry! Ticket return overdued.',
      name: 'ticket_return_overdued',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! This ticket class is not returnable!`
  String get ticket_return_not_suitable {
    return Intl.message(
      'Sorry! This ticket class is not returnable!',
      name: 'ticket_return_not_suitable',
      desc: '',
      args: [],
    );
  }

  /// `The return fee is {fee}. Do you want to proceed with the return?`
  String ticket_return_confirm(String fee) {
    return Intl.message(
      'The return fee is $fee. Do you want to proceed with the return?',
      name: 'ticket_return_confirm',
      desc: '',
      args: [fee],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `The ticket is returned successfully!`
  String get ticket_returned_successfully {
    return Intl.message(
      'The ticket is returned successfully!',
      name: 'ticket_returned_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Flight duration must be at least {minDuration} minutes!`
  String flight_duration_least(int minDuration) {
    return Intl.message(
      'Flight duration must be at least $minDuration minutes!',
      name: 'flight_duration_least',
      desc: '',
      args: [minDuration],
    );
  }

  /// `At intermediate airport, stop duration must belong to [{min}, {max}]!`
  String stop_duration_condition(int min, int max) {
    return Intl.message(
      'At intermediate airport, stop duration must belong to [$min, $max]!',
      name: 'stop_duration_condition',
      desc: '',
      args: [min, max],
    );
  }

  /// `Minimum flight duration`
  String get min_flight_duration {
    return Intl.message(
      'Minimum flight duration',
      name: 'min_flight_duration',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of intermediate airports`
  String get max_middle_airport {
    return Intl.message(
      'Maximum number of intermediate airports',
      name: 'max_middle_airport',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get minimum {
    return Intl.message(
      'Minimum',
      name: 'minimum',
      desc: '',
      args: [],
    );
  }

  /// `Maximum`
  String get maximum {
    return Intl.message(
      'Maximum',
      name: 'maximum',
      desc: '',
      args: [],
    );
  }

  /// `Latest time when booking (before departure)`
  String get latest_time_booking {
    return Intl.message(
      'Latest time when booking (before departure)',
      name: 'latest_time_booking',
      desc: '',
      args: [],
    );
  }

  /// `Latest time when returning (before departure)`
  String get latest_time_cancel_booking {
    return Intl.message(
      'Latest time when returning (before departure)',
      name: 'latest_time_cancel_booking',
      desc: '',
      args: [],
    );
  }

  /// `Rule`
  String get rule {
    return Intl.message(
      'Rule',
      name: 'rule',
      desc: '',
      args: [],
    );
  }

  /// `Rule updated successfully!`
  String get rule_updated_successfully {
    return Intl.message(
      'Rule updated successfully!',
      name: 'rule_updated_successfully',
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
