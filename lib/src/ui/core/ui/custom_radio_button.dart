import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatefulWidget {
  final List<T> items;
  final List<String>? labels;
  final void Function(T) onChanged;
  final bool? fullWidth;

  CustomRadioButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.fullWidth,
    this.labels,
  }) {
    if (labels != null) assert(items.length == labels!.length);
  }

  @override
  State<CustomRadioButton<T>> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
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
        //spacing: spacing,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.items.map((item) {
          return SizedBox(
            width: chipWidth,
            // height: 40,
            child: ChoiceChip(
              showCheckmark: true,
              selected: selectedValue == item,
              selectedColor: Theme.of(context).colorScheme.primary,
              checkmarkColor: Colors.white,
              //backgroundColor: Colors.amber,
              side: BorderSide(color: Theme.of(context).colorScheme.secondary),
              labelStyle: TextStyle(
                color: selectedValue == item
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
              ),
              label: Container(
                alignment: AlignmentDirectional.center,
                //width: chipWidth,
                height: 36,
                child: Text(
                  labels == null
                      ? item.toString()
                      : labels![items.indexOf(item)],
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
