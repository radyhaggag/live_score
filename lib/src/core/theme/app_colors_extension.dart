import 'package:flutter/material.dart';

/// Semantic colors and custom gradients extension for our theme.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color green;
  final Color red;
  final Color purple;
  final Color yellow;
  final Color darkGrey;
  final Color lightGrey;
  final Color grey;
  final Color deepOrange;
  final Color blueGrey;
  final Color blue;
  final Color white;
  final Color lightRed;
  final Color darkBlue;
  final Color darkGreen;
  final Gradient blueGradient;
  final Gradient redGradient;

  // New Fields
  final Color surfaceGlass;
  final Color surfaceElevated;
  final Color textMuted;
  final Color textSubtle;
  final Color dividerSubtle;
  final Color onLive;
  final Color onScheduled;
  final Color onEnded;
  final Gradient liveGradient;
  final Gradient accentGradient;

  const AppColorsExtension({
    required this.green,
    required this.red,
    required this.purple,
    required this.yellow,
    required this.darkGrey,
    required this.lightGrey,
    required this.grey,
    required this.deepOrange,
    required this.blueGrey,
    required this.blue,
    required this.white,
    required this.lightRed,
    required this.darkBlue,
    required this.darkGreen,
    required this.blueGradient,
    required this.redGradient,
    required this.surfaceGlass,
    required this.surfaceElevated,
    required this.textMuted,
    required this.textSubtle,
    required this.dividerSubtle,
    required this.onLive,
    required this.onScheduled,
    required this.onEnded,
    required this.liveGradient,
    required this.accentGradient,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? green,
    Color? red,
    Color? purple,
    Color? yellow,
    Color? darkGrey,
    Color? lightGrey,
    Color? grey,
    Color? deepOrange,
    Color? blueGrey,
    Color? blue,
    Color? white,
    Color? lightRed,
    Color? darkBlue,
    Color? darkGreen,
    Gradient? blueGradient,
    Gradient? redGradient,
    Color? surfaceGlass,
    Color? surfaceElevated,
    Color? textMuted,
    Color? textSubtle,
    Color? dividerSubtle,
    Color? onLive,
    Color? onScheduled,
    Color? onEnded,
    Gradient? liveGradient,
    Gradient? accentGradient,
  }) {
    return AppColorsExtension(
      green: green ?? this.green,
      red: red ?? this.red,
      purple: purple ?? this.purple,
      yellow: yellow ?? this.yellow,
      darkGrey: darkGrey ?? this.darkGrey,
      lightGrey: lightGrey ?? this.lightGrey,
      grey: grey ?? this.grey,
      deepOrange: deepOrange ?? this.deepOrange,
      blueGrey: blueGrey ?? this.blueGrey,
      blue: blue ?? this.blue,
      white: white ?? this.white,
      lightRed: lightRed ?? this.lightRed,
      darkBlue: darkBlue ?? this.darkBlue,
      darkGreen: darkGreen ?? this.darkGreen,
      blueGradient: blueGradient ?? this.blueGradient,
      redGradient: redGradient ?? this.redGradient,
      surfaceGlass: surfaceGlass ?? this.surfaceGlass,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      textMuted: textMuted ?? this.textMuted,
      textSubtle: textSubtle ?? this.textSubtle,
      dividerSubtle: dividerSubtle ?? this.dividerSubtle,
      onLive: onLive ?? this.onLive,
      onScheduled: onScheduled ?? this.onScheduled,
      onEnded: onEnded ?? this.onEnded,
      liveGradient: liveGradient ?? this.liveGradient,
      accentGradient: accentGradient ?? this.accentGradient,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      green: Color.lerp(green, other.green, t)!,
      red: Color.lerp(red, other.red, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      darkGrey: Color.lerp(darkGrey, other.darkGrey, t)!,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      deepOrange: Color.lerp(deepOrange, other.deepOrange, t)!,
      blueGrey: Color.lerp(blueGrey, other.blueGrey, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      white: Color.lerp(white, other.white, t)!,
      lightRed: Color.lerp(lightRed, other.lightRed, t)!,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t)!,
      darkGreen: Color.lerp(darkGreen, other.darkGreen, t)!,
      blueGradient: Gradient.lerp(blueGradient, other.blueGradient, t)!,
      redGradient: Gradient.lerp(redGradient, other.redGradient, t)!,
      surfaceGlass: Color.lerp(surfaceGlass, other.surfaceGlass, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t)!,
      dividerSubtle: Color.lerp(dividerSubtle, other.dividerSubtle, t)!,
      onLive: Color.lerp(onLive, other.onLive, t)!,
      onScheduled: Color.lerp(onScheduled, other.onScheduled, t)!,
      onEnded: Color.lerp(onEnded, other.onEnded, t)!,
      liveGradient: Gradient.lerp(liveGradient, other.liveGradient, t)!,
      accentGradient: Gradient.lerp(accentGradient, other.accentGradient, t)!,
    );
  }
}
