import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double getkDeviceWidthFactor(BuildContext context, double widgetWidth) {
  return (MediaQuery.of(context).size.width / 392.72727272727275) * widgetWidth;
}

double getkDeviceHeightFactor(BuildContext context, double widgetHeight) {
  return (MediaQuery.of(context).size.height / 807.2727272727273) *
      widgetHeight;
}
