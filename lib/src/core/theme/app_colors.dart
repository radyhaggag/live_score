import 'package:flutter/material.dart';

/// Represents the app colors entity/model.
class AppColors {
  AppColors._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0F172A);

  // Dark Mode Variants
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkOnSurface = Color(0xFFF8FAFC);
  static const Color darkScaffold = Color(0xFF0F172A);

  static const Color red = Color(0xFFE11D48);
  static const Color lightRed = Color(0xFFFB7185);

  static const Color blueGrey = Color(0xFF64748B);

  static const Color green = Color(0xFF10B981);
  static const Color darkGreen = Color(0xFF059669);

  static const Color yellow = Color(0xFFF59E0B);

  static const Color blue = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF1D4ED8);

  static const Color deepOrange = Color(0xFFF97316);

  static const Color grey = Color(0xFF94A3B8);
  static const Color darkGrey = Color(0xFF475569);

  // Added for standings clarity
  static const Color purple = Color(0xFF8B5CF6);
  static const Color lightGrey = Color(0xFFF1F5F9);

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[blue, darkBlue],
  );

  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[lightRed, red],
  );
}
