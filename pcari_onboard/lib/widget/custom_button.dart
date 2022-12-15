import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final Color? splashColor;
  final double? width;
  final double? height;
  final Color? color;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final double? shadowRadius;
  final VoidCallback? onTap;
  final Offset? shadowOffset;
  final bool? isShadow;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? hoverColor;
  final Gradient? gradient;
  final BoxConstraints? constraints;
  final Color? borderColor;
  final double? borderWidth;
  const CustomButton({Key? key, this.onTap, this.constraints, this.borderColor, this.borderWidth, required this.child, this.gradient, this.color, this.margin, this.hoverColor, this.shadowOffset, this.shadowColor, this.borderRadius, this.isShadow, this.shadowRadius, this.padding, this.width, this.height, this.splashColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: constraints,
        width: width,
        height: height,
        margin: margin ?? EdgeInsets.all(10),
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? Get.theme.cardColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            gradient: gradient,
            border: borderColor != null || borderWidth != null ? Border.all(color: borderColor ?? Colors.black, width: borderWidth ?? 1) : null,
            boxShadow: isShadow == true || isShadow == null ? [
              BoxShadow(
                color: shadowColor ?? Colors.black.withOpacity(0.1),
                blurRadius: shadowRadius != null ? shadowRadius! + 5 : 7,
                spreadRadius: shadowRadius != null ? shadowRadius! : 2,
                offset: shadowOffset ?? Offset(0,3)
              )
            ] : null
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            splashColor: splashColor ?? (gradient != null ? Colors.red : Colors.grey.shade400),
            hoverColor: hoverColor,
            onTap: onTap,
            child: Container(
              padding: padding ?? EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}