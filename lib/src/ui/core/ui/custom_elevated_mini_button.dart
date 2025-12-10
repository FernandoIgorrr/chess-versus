import 'package:flutter/material.dart';
import 'base_button.dart';

class CustomElevatedMiniButton extends BaseButton {
  const CustomElevatedMiniButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    //super.height,
    super.width,
    required super.text,
    this.height,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  // ignore: overridden_fields
  final double? height;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget(context),
          )
        : buildElevatedButtonWidget(context);
  }

  Widget buildElevatedButtonWidget(BuildContext context) => Container(
    // height: height ?? 40,
    width: width ?? double.maxFinite,
    height: height,
    margin: margin,
    decoration: decoration,

    child: ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,

      child: Text(
        text,
        style: buttonTextStyle ?? Theme.of(context).textTheme.bodySmall,
      ),
    ),
  );
}
