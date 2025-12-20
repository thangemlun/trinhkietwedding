import 'package:flutter/cupertino.dart';

class ResponsiveHelper {
  static double scaleWidth(BuildContext context, double size, double designWith) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return size * deviceWidth/ designWith;
  }

  static double scaleHeight(BuildContext context, double size, double designHeight) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return size * deviceHeight / designHeight;
  }
}