import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  T selectedItem;
  final List<DropdownMenuItem<T>> items;
  final void Function(dynamic)? onChanged;

  CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown> {
  @override
  void initState() {
    super.initState();
    widget.selectedItem = widget.items.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      alignment: AlignmentDirectional.center,
      isExpanded: true,
      value: widget.selectedItem,
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
      items: widget.items,
      onChanged: widget.onChanged,
    );
  }
}
