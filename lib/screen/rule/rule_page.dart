import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/rule.dart';
import 'package:simplane_client_admin/util/constants.dart';

import 'rule_bloc.dart';

class RulePage extends StatefulWidget {
  static const pageName = 'rule';

  const RulePage({Key? key}) : super(key: key);

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  final _ruleBloc = RuleBloc();
  final _formKey = GlobalKey<FormState>();
  final _minFlightDurationController = TextEditingController();
  final _maxMiddleAirportController = TextEditingController();
  final _minStopDurationController = TextEditingController();
  final _maxStopDurationController = TextEditingController();
  final _latestTimeBookingController = TextEditingController();
  final _latestTimeCancelBookingController = TextEditingController();

  _setRuleData(Rule rule) {
    setState(() {
      _minFlightDurationController.text =
          rule.minFlightDuration.toInt().toString();
      _maxMiddleAirportController.text =
          rule.maxMiddleAirport.toInt().toString();
      _minStopDurationController.text = rule.minStopDuration.toInt().toString();
      _maxStopDurationController.text = rule.maxStopDuration.toInt().toString();
      _latestTimeBookingController.text =
          rule.latestTimeBooking.toInt().toString();
      _latestTimeCancelBookingController.text =
          rule.latestTimeCancelBooking.toInt().toString();
    });
  }

  @override
  void initState() {
    _ruleBloc.add(LoadRule());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RuleBloc, RuleState>(
      bloc: _ruleBloc,
      listenWhen: (prev, curr) =>
          curr is RuleLoading ||
          curr is RuleError ||
          curr is RuleLoaded ||
          curr is RuleUpdated,
      listener: (ctx, state) {
        EasyLoading.dismiss();
        if (state is RuleLoading) {
          EasyLoading.show();
        } else if (state is RuleError) {
          EasyLoading.showError(state.error);
        } else if (state is RuleLoaded) {
          _setRuleData(state.rule);
        } else if (state is RuleUpdated) {
          EasyLoading.showSuccess(S.current.rule_updated_successfully);
          _setRuleData(state.rule);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              _fieldTitle(S.current.min_flight_duration),
              _textField(controller: _minFlightDurationController),
              _fieldTitle(S.current.max_middle_airport),
              _textField(controller: _maxMiddleAirportController),
              _fieldTitle(S.current.stop_duration),
              Row(
                children: [
                  Expanded(
                      child: _textField(
                          label: S.current.minimum,
                          controller: _minStopDurationController,
                          numberOnly: true)),
                  const SizedBox(width: 20),
                  Expanded(
                      child: _textField(
                          label: S.current.maximum,
                          controller: _maxStopDurationController,
                          numberOnly: true)),
                ],
              ),
              _fieldTitle(S.current.latest_time_booking),
              _textField(controller: _latestTimeBookingController),
              _fieldTitle(S.current.latest_time_cancel_booking),
              _textField(controller: _latestTimeCancelBookingController),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        S.current.update,
                        style: AppStyle.content.copyWith(color: Colors.white),
                      )),
                  onPressed: () => _onSubmit(),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.secondary,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _ruleBloc.add(UpdateRule(
        double.parse(_minFlightDurationController.text),
        double.parse(_maxMiddleAirportController.text),
        double.parse(_minStopDurationController.text),
        double.parse(_maxStopDurationController.text),
        double.parse(_latestTimeBookingController.text),
        double.parse(_latestTimeCancelBookingController.text),
      ));
    }
  }

  Widget _fieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        title,
        style: AppStyle.content,
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
