import 'package:flutter/material.dart';
import '../common/my_color.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget circle(
      {double? heigh,
      double? width,
      double? top,
      double? bottom,
      double? left,
      double? right,}
    ) => Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        height: heigh,
        width: width,
        decoration: BoxDecoration(
          color: MyColor.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(1000.0),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        circle(
          width: 200,
          heigh: 200,
          right: -50.0,
          top: -140.0,
        ),
        circle(
          width: 180,
          heigh: 180,
          right: -110.0,
          top: -60.0,
        ),
      ],
    );
  }
}