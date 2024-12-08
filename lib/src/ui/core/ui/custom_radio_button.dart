import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T) onChanged;

  CustomRadioButton({
    super.key,
    required this.items,
    required this.onChanged,
  }) {
    // Validando o tipo no construtor
    if (!(T == int || T == double || T == bool || T == String)) {
      throw ArgumentError(
          'CustomRadioButton only supports types: int, double, bool, and String');
    }
  }

  @override
  State<CustomRadioButton<T>> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  late T selectedValue;
  late final List<T> items;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      var choices = widget.items;
      double spacing = 8;
      double chipWidth =
          (maxWidth - (spacing * (choices.length - 1))) / choices.length;
      return Wrap(
        spacing: spacing,
        children: widget.items.map((item) {
          return SizedBox(
            width: chipWidth,
            child: ChoiceChip(
              showCheckmark: false,
              selected: selectedValue == item,
              selectedColor: Theme.of(context).colorScheme.primary,

              //backgroundColor: Colors.amber,
              side: BorderSide(color: Theme.of(context).colorScheme.secondary),
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
              label: Container(
                alignment: AlignmentDirectional.center,
                //width: chipWidth,
                // height: 40,
                child: Text(
                  item.toString(),
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
