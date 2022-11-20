import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  AppColors._();
  static const Color white = Color(0xFFFAFAFA);
  static const Color black = Color(0xFF131313);
  static const Color red = Color(0xFFCA0825);
  static const Color lightRed = Color(0xFFF44336);
  static const Color blueGrey = Color(0xFF607D8B);
  static const Color green = Color(0xFF21C13B);
  static const Color darkGreen = Color(0xFF4CAF50);
  static const Color yellow = Color(0xFFE7E20E);
  static const Color blue = Color(0xFF4373D9);
  static const Color darkBlue = Color(0xFF133E99);
  static const Color deepOrange = Color(0xFFFF5722);
  static const Color grey = Color(0xFF9E9E9E);
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[darkBlue, blue],
  );
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[lightRed, red],
  );
}
