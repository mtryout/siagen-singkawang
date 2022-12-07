// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final Color bgColor;
  final LinearGradient? bgGradient;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool shadow;
  final Color shadowColor;
  final double shadowOpacity;
  final double elevationX;
  final double elevationY;
  final double shadowBlur;
  final Widget? child;

  const CustomCard({
    Key? key,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.height,
    this.width,
    this.bgColor = Colors.transparent,
    this.bgGradient,
    this.borderRadius,
    this.border,
    this.shadow = false,
    this.shadowColor = Colors.grey,
    this.shadowOpacity = 1,
    this.elevationX = 0,
    this.elevationY = 1,
    this.shadowBlur = 6,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: bgColor,
          gradient: bgGradient,
          border: border,
          borderRadius:
              borderRadius == null ? BorderRadius.circular(10) : borderRadius,
          boxShadow: [
            if (shadow)
              BoxShadow(
                color: shadowColor.withOpacity(shadowOpacity),
                offset: Offset(elevationX, elevationY),
                blurRadius: shadowBlur,
              ),
          ]),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius == null ? BorderRadius.circular(10) : borderRadius!,
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        color: Colors.transparent,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
                padding: padding, child: child == null ? Container() : child),
          ),
        ),
      ),
    );
  }
}
