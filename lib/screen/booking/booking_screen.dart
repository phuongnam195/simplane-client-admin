import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/passenger.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/screen/booking/booking_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/utils.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = '/booking';

  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _bookingBloc = BookingBloc();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _identityController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _lastNameNode = FocusNode();
  final _identityNode = FocusNode();
  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  late final Flight _flight;
  final Map<String, Map<String, dynamic>> _mapTicketClass = {};
  late String _selectedTicketClass;

  @override
  void initState() {
    _flight = Get.arguments;

    for (var tc in RuleManager.instance.getListTicketClass()) {
      _mapTicketClass[tc.id] = {
        'name': tc.name,
        'avail': countAvailTicket(tc),
        'price': getTicketPrice(tc),
      };
    }

    _selectedTicketClass = RuleManager.instance.getListTicketClass()[0].id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.booking_title(_flight.code),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                //Text(S.current.pick_ticket_class, style: AppStyle.heading),
                _fieldHeading(S.current.pick_ticket_class),
                // const SizedBox(height: 10),
                _radioGroupTicketClasses(),
                const SizedBox(height: 20),
                //Text(S.current.passenger_info, style: AppStyle.heading),
                _fieldHeading(S.current.passenger_info),
                _fieldTitle(S.current.fullname),
                Row(
                  children: [
                    Expanded(
                        child: _textField(
                            controller: _firstNameController,
                            label: S.current.first_name,
                            onEditingComplete: () {
                              _lastNameNode.requestFocus();
                            })),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _textField(
                          label: S.current.last_name,
                          controller: _lastNameController,
                          focusNode: _lastNameNode,
                          onEditingComplete: () {
                            _identityNode.requestFocus();
                          }),
                    ),
                  ],
                ),
                _fieldTitle(S.current.identity_number),
                _textField(
                    // label: S.current.identity_number,
                    controller: _identityController,
                    focusNode: _identityNode,
                    onEditingComplete: () {
                      _emailNode.requestFocus();
                    }),
                _fieldTitle(S.current.email_address),
                _textField(
                    // label: S.current.email_address,
                    controller: _emailController,
                    focusNode: _emailNode,
                    onEditingComplete: () {
                      _phoneNode.requestFocus();
                    }),
                _fieldTitle(S.current.phone_number),
                _textField(
                    // label: S.current.phone_number,
                    controller: _phoneController,
                    focusNode: _phoneNode),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Text(
                          S.current.confirm,
                          style: AppStyle.content.copyWith(color: Colors.white),
                        )),
                    onPressed: () => _onSubmit(),
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.secondary,
                      shape: const StadiumBorder(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final passenger = Passenger(
        id: 'set trên server',
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        identityNumber: _identityController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
      );

      _bookingBloc.add(
        ConfirmBooking(
          flight: _flight,
          passenger: passenger,
          ticketClassId: _selectedTicketClass,
          price: _mapTicketClass[_selectedTicketClass]?['price'] ?? -1,
        ),
      );
    }
  }

  Widget _radioGroupTicketClasses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (var tcId in _mapTicketClass.keys)
          if (_mapTicketClass[tcId]?['avail'] > 0) _radioTicketClass(tcId)
      ],
    );
  }

  Widget _radioTicketClass(String tcId) {
    String name = _mapTicketClass[tcId]?['name'];
    int avail = _mapTicketClass[tcId]?['avail'];
    double price = _mapTicketClass[tcId]?['price'];
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _selectedTicketClass = tcId;
        }),
        child: Row(children: [
          Radio<String>(
              value: tcId,
              groupValue: _selectedTicketClass,
              onChanged: (_) {
                setState(() {
                  _selectedTicketClass = tcId;
                });
              }),
          Expanded(
            child: _radioContent(
                '[$tcId] $name\n${S.current.avail_ticket_count(avail)}\n${formatCurrency(price)}'),
          )
        ]),
      ),
    );
  }

  // Widget _textField(String label, TextEditingController controller,
  //     {bool? readOnly,
  //     FocusNode? focusNode,
  //     String? errorText,
  //     void Function()? onEditingComplete}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: TextFormField(
  //       controller: controller,
  //       decoration: InputDecoration(labelText: label, errorText: errorText),
  //       focusNode: focusNode,
  //       style: const TextStyle(fontSize: 16),
  //       readOnly: readOnly ?? false,
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return S.current.not_empty;
  //         }
  //         return null;
  //       },
  //       onEditingComplete: onEditingComplete,
  //     ),
  //   );
  // }

  double getTicketPrice(TicketClass tc) =>
      _flight.ticketClassPrice[tc.id] ?? 0.0;
  int countTotalTicket(TicketClass tc) =>
      _flight.seatAmount[tc.id]?.toInt() ?? 0;
  int countAvailTicket(TicketClass tc) =>
      countTotalTicket(tc) - (_flight.bookedAmount[tc.id]?.toInt() ?? 0);

  Widget _fieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        title,
        style: AppStyle.content,
      ),
    );
  }

  Widget _radioContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _fieldHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        heading,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField({
    TextEditingController? controller,
    String? label,
    bool? readOnly,
    FocusNode? focusNode,
    String? errorText,
    void Function()? onEditingComplete,
    bool numberOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        focusNode: focusNode,
        style: const TextStyle(fontSize: 16),
        readOnly: readOnly ?? false,
        keyboardType: numberOnly ? TextInputType.number : null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.current.not_empty;
          }
          return null;
        },
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
