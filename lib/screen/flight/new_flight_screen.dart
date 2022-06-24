import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';

import 'new_flight_bloc.dart';

class NewFlightScreen extends StatefulWidget {
  static const routeName = '/add-flight';

  const NewFlightScreen({Key? key}) : super(key: key);

  @override
  State<NewFlightScreen> createState() => _NewFlightScreenState();
}

class _NewFlightScreenState extends State<NewFlightScreen> {
  final _newFlightBloc = NewFlightBloc();
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _durationController = TextEditingController();
  late final List<TextEditingController> _seatAmountController;
  late final List<TextEditingController> _priceController;
  late final List<TextEditingController> _stopDurationControllers;
  final List<TicketClass> _listTicketClass =
      RuleManager.instance.rule!.ticketClasses;
  final List<Airport> _listAirport = [];
  Airport? _selectedFromAirport;
  Airport? _selectedToAirport;
  final List<Airport> _selectedMiddleAirports = [];
  DateTime? _dateTime;
  bool _dataInited = false;
  final maxMiddleAirport = RuleManager.instance.rule!.maxMiddleAirport.toInt();

  @override
  void initState() {
    _newFlightBloc.add(InitData());
    _seatAmountController = List.generate(
        _listTicketClass.length, (i) => TextEditingController(),
        growable: false);
    _priceController = List.generate(
        _listTicketClass.length, (i) => TextEditingController(),
        growable: false);
    _stopDurationControllers = List.generate(
        maxMiddleAirport, (i) => TextEditingController(),
        growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewFlightBloc, NewFlightState>(
      bloc: _newFlightBloc,
      listenWhen: (prev, curr) =>
          curr is NewFlightLoading ||
          curr is NewFlightError ||
          curr is DataInited ||
          curr is FlightAdded,
      listener: (ctx, state) {
        EasyLoading.dismiss();
        if (state is NewFlightLoading) {
          EasyLoading.show();
        } else if (state is NewFlightError) {
          EasyLoading.showError(state.error);
        } else if (state is DataInited) {
          setState(() {
            _listAirport.clear();
            _listAirport.addAll(state.airports);
            _selectedFromAirport = _listAirport[0];
            _selectedToAirport = _listAirport[1];
            _dataInited = true;
          });
        } else if (state is FlightAdded) {
          EasyLoading.showSuccess(S.current.add_flight_successfully)
              .then((_) => Get.back(result: true));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: Text(S.current.new_flight),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            child: const Icon(Icons.done),
            onPressed: () => _onSubmit(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3.5),
            child: Form(
              key: _formKey,
              child: !_dataInited
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const SizedBox(height: 20),
                          // _fieldTitle(S.current.flight_code),
                          // _textField(controller: _codeController),
                          _fieldTitle(S.current.departure_airport),
                          _dropdownField<Airport>(
                              value: _selectedFromAirport!,
                              onChanged: (value) => _selectedFromAirport =
                                  value ?? _selectedFromAirport,
                              menuItems:
                                  _getDropdownMenuAirports(_freeFromAirports)),
                          _fieldTitle(S.current.arrival_airport),
                          _dropdownField<Airport>(
                              title: S.current.arrival_airport,
                              value: _selectedToAirport!,
                              onChanged: (value) => _selectedToAirport =
                                  value ?? _selectedToAirport,
                              menuItems:
                                  _getDropdownMenuAirports(_freeToAirports)),
                          _fieldTitle(S.current.flight_date),
                          DateTimeField(
                            format: DateFormat('hh:mm dd/MM/yyyy'),
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                context: context,
                                firstDate: DateTimeUtils.today(),
                                initialDate:
                                    currentValue ?? DateTimeUtils.today(),
                                lastDate: DateTime(DateTime.now().year + 5),
                              );
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                _dateTime = DateTimeField.combine(date, time);
                                return _dateTime;
                              } else {
                                return currentValue;
                              }
                            },
                            onSaved: (dateTime) {
                              _dateTime = dateTime;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          _fieldTitle(S.current.flight_duration),
                          _textField(
                              controller: _durationController,
                              numberOnly: true),
                          for (int i = 0; i < _listTicketClass.length; i++)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _fieldTitle(S.current.ticket_class_info(
                                    _listTicketClass[i].name)),
                                Row(
                                  children: [
                                    Expanded(
                                        child: _textField(
                                            label: S.current.seat_amount,
                                            controller:
                                                _seatAmountController[i],
                                            numberOnly: true)),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: _textField(
                                            label: S.current.price,
                                            controller: _priceController[i],
                                            numberOnly: true)),
                                  ],
                                )
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _fieldTitle(S.current.intermediate_airport),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: _selectedMiddleAirports.length <
                                        maxMiddleAirport
                                    ? () {
                                        setState(() {
                                          _selectedMiddleAirports
                                              .add(_freeMiddleAirports[0]);
                                        });
                                      }
                                    : null,
                              ),
                            ],
                          ),
                          for (int i = 0;
                              i < _selectedMiddleAirports.length;
                              i++)
                            Row(
                              children: [
                                Expanded(
                                  child: _dropdownField<Airport>(
                                      title: S.current.arrival_airport,
                                      value: _selectedMiddleAirports[i],
                                      onChanged: (value) =>
                                          _selectedMiddleAirports[i] = value ??
                                              _selectedMiddleAirports[i],
                                      menuItems: _getDropdownMenuAirports(
                                          _freeMiddleAirports
                                            ..add(_selectedMiddleAirports[i]))),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _textField(
                                      label: S.current.stop_duration,
                                      controller: _stopDurationControllers[i]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      _selectedMiddleAirports.removeAt(i);
                                    });
                                  },
                                )
                              ],
                            ),
                          const SizedBox(height: 80),
                        ]),
            ),
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_dateTime == null) {
      return;
    }
    if (double.tryParse(_durationController.text) == null) {
      return;
    }

    _formKey.currentState!.save();

    Map<String, double> ticketClassPrice = {};
    Map<String, double> seatAmount = {};
    Map<String, double> bookedAmount = {};

    for (int i = 0; i < _listTicketClass.length; i++) {
      ticketClassPrice[_listTicketClass[i].id] =
          double.tryParse(_priceController[i].text) ?? 0;
      seatAmount[_listTicketClass[i].id] =
          double.tryParse(_seatAmountController[i].text) ?? 0;
      bookedAmount[_listTicketClass[i].id] = 0;
    }

    List<double> stopDurations = _stopDurationControllers.map((controller) {
      return double.tryParse(controller.text) ?? 0;
    }).toList();

    _newFlightBloc.add(AddFlight(
        flightCode: 'set trên server',
        fromAirport: _selectedFromAirport!,
        toAirport: _selectedToAirport!,
        flightDate: _dateTime!,
        duration: double.tryParse(_durationController.text)!,
        ticketClassPrice: ticketClassPrice,
        seatAmount: seatAmount,
        bookedAmount: bookedAmount,
        middleAirports: _selectedMiddleAirports,
        stopDurations: stopDurations));
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

  Widget _dropdownField<T>({
    String? title,
    required T value,
    required List<DropdownMenuItem<T>> menuItems,
    Function(T? newValue)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          return InputDecorator(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                labelStyle: const TextStyle(fontSize: 16),
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 16),
                hintText: title,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            isEmpty: value == null || value == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    state.didChange(newValue);
                    onChanged?.call(newValue);
                  });
                },
                items: menuItems,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Airport> get _freeFromAirports => _listAirport
      .where((a) =>
          a != _selectedToAirport && !_selectedMiddleAirports.contains(a))
      .toList();
  List<Airport> get _freeToAirports => _listAirport
      .where((a) =>
          a != _selectedFromAirport && !_selectedMiddleAirports.contains(a))
      .toList();
  List<Airport> get _freeMiddleAirports => _listAirport
      .where((a) =>
          a != _selectedToAirport &&
          a != _selectedFromAirport &&
          !_selectedMiddleAirports.contains(a))
      .toList();

  List<DropdownMenuItem<Airport>> _getDropdownMenuAirports(
          List<Airport> airports) =>
      airports
          .map((airport) => DropdownMenuItem(
                value: airport,
                child: Text('${airport.name} (${airport.code})'),
              ))
          .toList();

  Widget _fieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        title,
        style: AppStyle.content,
      ),
    );
  }
}
