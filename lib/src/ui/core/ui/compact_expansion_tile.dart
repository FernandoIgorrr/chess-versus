import 'package:flutter/material.dart';

class CompactExpansionTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final EdgeInsetsGeometry tilePadding;
  final bool initiallyExpanded;
  final ShapeBorder? shape;
  final ShapeBorder? collapsedShape;

  const CompactExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.tilePadding = const EdgeInsets.symmetric(horizontal: 12),
    this.initiallyExpanded = false,
    this.shape,
    this.collapsedShape,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      dense: true,
      visualDensity: VisualDensity.compact,
      tilePadding: tilePadding,
      childrenPadding: EdgeInsets.zero,
      //dividerColor: Colors.transparent,

      // 👇 shapes configuráveis
      shape: shape ?? const RoundedRectangleBorder(side: BorderSide.none),
      collapsedShape:
          collapsedShape ?? const RoundedRectangleBorder(side: BorderSide.none),

      title: title,
      children: children,
    );
  }
}
