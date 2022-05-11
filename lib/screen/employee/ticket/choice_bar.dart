import 'package:flutter/material.dart';
import 'package:simplane_client_admin/util/constants.dart';

class ChoiceBar extends StatefulWidget {
  const ChoiceBar(this.mapLabel, {Key? key}) : super(key: key);

  final Map<String, void Function()> mapLabel; // key: label, value: onSelected

  @override
  State<ChoiceBar> createState() => _ChoiceBarState();
}

class _ChoiceBarState extends State<ChoiceBar> {
  late String _current;

  @override
  void initState() {
    _current = widget.mapLabel.keys.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.mapLabel.entries.map<Widget>((data) {
        final label = data.key;
        final onSelected = data.value;
        return _wxChoice(data.key, _current == label, () {
          if (_current == label) return;
          setState(() {
            _current = label;
          });
          onSelected.call();
        });
      }).toList(),
    );
  }

  Widget _wxChoice(String label, bool selected, void Function() onSelected) {
    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 100),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: selected ? const Color(0xFF7985CB) : const Color(0xFFEFF0FA),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              label,
              style: AppStyle.content.copyWith(
                  color: selected ? Colors.white : const Color(0xFF4C589E)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
