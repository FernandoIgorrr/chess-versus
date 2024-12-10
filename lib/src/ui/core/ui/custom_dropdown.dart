import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T)? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    this.onChanged,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late List<DropdownMenuItem<T>> items;
  late T defaultItem;
  late T? controller;

  @override
  void initState() {
    super.initState();
    defaultItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        alignment: AlignmentDirectional.center,
        isExpanded: true,
        value: defaultItem,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
          ),
        ),
        items: widget.items.map<DropdownMenuItem<T>>((value) {
          return DropdownMenuItem<T>(
            alignment: AlignmentDirectional.center,
            value: value,
            child: Text(
              value.toString(),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value == null) return;
          setState(() {
            controller = value;
          });
          widget.onChanged?.call(value);
        });
  }
}
