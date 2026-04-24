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

  static const Color purple = Color(0xFF8B5CF6);
  static const Color lightGrey = Color(0xFFF1F5F9);

  // New Semantic Surface & Glass Colors
  static const Color lightSurfaceGlass = Color(0xCCFFFFFF); // 80% opacity
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);
  static const Color darkSurfaceGlass = Color(0xCC1E293B); // 80% opacity
  static const Color darkSurfaceElevated = Color(0xFF334155);

  // Text & Dividers
  static const Color lightTextMuted = Color(0xFF64748B);
  static const Color lightTextSubtle = Color(0xFF94A3B8);
  static const Color lightDividerSubtle = Color(0xFFE2E8F0);

  static const Color darkTextMuted = Color(0xFF94A3B8);
  static const Color darkTextSubtle = Color(0xFF64748B);
  static const Color darkDividerSubtle = Color(0xFF334155);

  // Status
  static const Color onLive = red;
  static const Color onScheduled = yellow;
  static const Color onEnded = grey;

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

  static const LinearGradient liveGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[lightRed, red],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF60A5FA), blue],
  );
}
