import 'package:flutter/material.dart';

import 'my_color.dart';
import 'my_size.dart';

class MyStyle {
  static TextStyle textButton = TextStyle(
      color: MyColor.white,
      fontSize: MySize.medium,
      fontWeight: FontWeight.bold);

  static TextStyle textTitle = TextStyle(
      color: MyColor.black,
      fontSize: MySize.large,
      fontWeight: FontWeight.bold);

  static TextStyle textParagraph = TextStyle(
    color: MyColor.black,
    fontSize: MySize.medium,
  );

  static TextStyle subText = TextStyle(
    color: MyColor.black,
    fontSize: MySize.small,
  );
}
