import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/util/constants.dart';

import 'airport_bloc.dart';

class AirportForm extends StatefulWidget {
  final Airport? data;

  const AirportForm(this.data, {Key? key}) : super(key: key);

  @override
  State<AirportForm> createState() => _AirportFormState();
}

class _AirportFormState extends State<AirportForm> {
  final _airportBloc = AirportBloc();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _nameNode = FocusNode();
  final _addressNode = FocusNode();
  bool _isAddition = true;

  @override
  void initState() {
    if (widget.data != null) {
      _isAddition = false;
      _codeController.text = widget.data!.code;
      _nameController.text = widget.data!.name;
      _addressController.text = widget.data!.address;
    }
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AirportBloc, AirportState>(
      bloc: _airportBloc,
      listenWhen: (prev, curr) =>
          curr is AirportLoading ||
          curr is AirportError ||
          curr is AirportAdded ||
          curr is AirportUpdated ||
          curr is AirportDeleted,
      listener: (ctx, state) {
        EasyLoading.dismiss();
        if (state is AirportLoading) {
          EasyLoading.show();
        } else if (state is AirportError) {
          EasyLoading.showError(state.error);
        } else if (state is AirportAdded) {
          Get.back(result: S.current.add_airport_successfully);
        } else if (state is AirportUpdated) {
          Get.back(result: S.current.update_airport_successfully);
        } else if (state is AirportDeleted) {
          Get.back(result: S.current.delete_airport_successfully);
        }
      },
      child: AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _formHeading(_isAddition
                  ? S.current.add_airport
                  : S.current.airport_info_update),
              const SizedBox(height: 10),
              _fieldTitle(S.current.code),
              _textField(
                  controller: _codeController,
                  onEditingComplete: () {
                    _nameNode.requestFocus();
                  }),
              _fieldTitle(S.current.name),
              _textField(
                  controller: _nameController,
                  focusNode: _nameNode,
                  onEditingComplete: () {
                    _addressNode.requestFocus();
                  }),
              _fieldTitle(S.current.address),
              _textField(
                  controller: _addressController, focusNode: _addressNode),
              const SizedBox(height: 20),
              _isAddition
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _button(
                          label: S.current.cancel,
                          color: AppColor.negative,
                          onPressed: () => Get.back(result: false),
                        ),
                        const SizedBox(width: 20),
                        _button(
                          label: S.current.confirm,
                          onPressed: () => _onAdd(),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _button(
                          label: S.current.delete,
                          color: Colors.red,
                          onPressed: () => _onDelete(),
                        ),
                        const SizedBox(width: 20),
                        _button(
                          label: S.current.update,
                          onPressed: () => _onUpdate(),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(
      {required String label,
      Color color = AppColor.secondary,
      void Function()? onPressed}) {
    return ElevatedButton(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Text(
            label,
            style: AppStyle.content.copyWith(color: Colors.white),
          )),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: const StadiumBorder(),
      ),
    );
  }

  Widget _formHeading(String heading) {
    return Center(
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

  Widget _fieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        title,
        style: AppStyle.content,
      ),
    );
  }

  _onAdd() {
    Airport airport = Airport(
        id: 'not set',
        code: _codeController.text,
        name: _nameController.text,
        address: _addressController.text);
    _airportBloc.add(AddAirport(airport));
  }

  _onUpdate() {
    Airport newData = Airport(
        id: widget.data!.id,
        code: _codeController.text,
        name: _nameController.text,
        address: _addressController.text);
    _airportBloc.add(UpdateAirport(newData));
  }

  _onDelete() {
    _airportBloc.add(DeleteAirport(widget.data!));
  }
}
