import 'package:flutter/material.dart';

class RadioButtonChip<T> extends StatefulWidget {
  final List<T> items;
  final List<String>? labels;
  final void Function(T) onChanged;
  final bool? fullWidth;

  RadioButtonChip({
    super.key,
    required this.items,
    required this.onChanged,
    this.fullWidth,
    this.labels,
  }) {
    if (labels != null) assert(items.length == labels!.length);
  }

  @override
  State<RadioButtonChip<T>> createState() => _RadioButtonChipState<T>();
}

class _RadioButtonChipState<T> extends State<RadioButtonChip<T>> {
  late bool fullWidth;
  late T selectedValue;
  late final List<T> items;
  late final List<String>? labels;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.first;
    fullWidth = widget.fullWidth ?? false;
    items = widget.items;
    labels = widget.labels;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double spacing = 8;

      double? chipWidth = fullWidth
          ? (maxWidth - (spacing * (items.length - 1))) / items.length
          : null;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.items.map((item) {
          return SizedBox(
            width: chipWidth,
            // height: 40,
            child: ChoiceChip(
              showCheckmark: true,
              selected: selectedValue == item,
              selectedColor: Theme.of(context).colorScheme.primary,
              //checkmarkColor: Theme.of(context).colorScheme.secondary,
              //backgroundColor: Colors.amber,
              side: BorderSide(color: Theme.of(context).colorScheme.secondary),
              labelStyle: selectedValue == item
                  ? Theme.of(context).textTheme.displayMedium
                  : Theme.of(context).textTheme.bodyMedium,

              label: Container(
                alignment: AlignmentDirectional.center,
                //width: chipWidth,
                height: 36,
                child: Text(
                  labels == null
                      ? item.toString()
                      : labels![items.indexOf(item)],
                  // style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              onSelected: (selected) {
                if (selectedValue != item) {
                  setState(() {
                    selectedValue = item;
                  });
                  widget.onChanged(item);
                }
              },
            ),
          );
        }).toList(),
      );
    });
  }
}
