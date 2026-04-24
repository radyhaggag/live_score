import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_fonts.dart';
import 'app_colors.dart';
import 'app_colors_extension.dart';
import '../constants/app_decorations.dart';

ThemeData getLightAppTheme() => _buildTheme(
  colorScheme: const ColorScheme.light(
    primary: AppColors.blue,
    secondary: AppColors.darkBlue,
    surface: AppColors.white,
    onSurface: AppColors.black,
  ),
  scaffoldBackgroundColor: AppColors.lightGrey,
  surfaceColor: AppColors.white,
  onSurfaceColor: AppColors.black,
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
  surfaceGlass: AppColors.lightSurfaceGlass,
  surfaceElevated: AppColors.lightSurfaceElevated,
  textMuted: AppColors.lightTextMuted,
  textSubtle: AppColors.lightTextSubtle,
  dividerSubtle: AppColors.lightDividerSubtle,
);

ThemeData getDarkAppTheme() => _buildTheme(
  colorScheme: const ColorScheme.dark(
    primary: AppColors.blue,
    secondary: AppColors.lightRed,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
  ),
  scaffoldBackgroundColor: AppColors.darkScaffold,
  surfaceColor: AppColors.darkSurface,
  onSurfaceColor: AppColors.darkOnSurface,
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
  surfaceGlass: AppColors.darkSurfaceGlass,
  surfaceElevated: AppColors.darkSurfaceElevated,
  textMuted: AppColors.darkTextMuted,
  textSubtle: AppColors.darkTextSubtle,
  dividerSubtle: AppColors.darkDividerSubtle,
);

ThemeData _buildTheme({
  required ColorScheme colorScheme,
  required Color scaffoldBackgroundColor,
  required Color surfaceColor,
  required Color onSurfaceColor,
  required Color statusBarColor,
  required Brightness statusBarIconBrightness,
  required Brightness statusBarBrightness,
  required Color surfaceGlass,
  required Color surfaceElevated,
  required Color textMuted,
  required Color textSubtle,
  required Color dividerSubtle,
}) {
  final baseTextTheme = TextTheme(
    displayMedium: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.heroScore,
      fontWeight: FontWeights.extraBold,
      letterSpacing: AppLetterSpacing.tight,
    ),
    displaySmall: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.mainTitle,
      fontWeight: FontWeights.extraBold,
      letterSpacing: AppLetterSpacing.tight,
    ),
    headlineSmall: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.title,
      fontWeight: FontWeights.bold,
      letterSpacing: AppLetterSpacing.tight,
    ),
    titleLarge: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.title,
      fontWeight: FontWeights.extraBold,
      letterSpacing: AppLetterSpacing.tight,
    ),
    titleMedium: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.subTitle,
      fontWeight: FontWeights.bold,
      letterSpacing: AppLetterSpacing.normal,
    ),
    titleSmall: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.bodyText,
      fontWeight: FontWeights.semiBold,
      letterSpacing: AppLetterSpacing.normal,
    ),
    bodyLarge: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.subTitle,
      fontWeight: FontWeights.semiBold,
      letterSpacing: AppLetterSpacing.normal,
    ),
    bodyMedium: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.bodyText,
      fontWeight: FontWeights.regular,
      letterSpacing: AppLetterSpacing.normal,
    ),
    bodySmall: TextStyle(
      color: textMuted,
      fontSize: FontSize.details,
      fontWeight: FontWeights.medium,
      letterSpacing: AppLetterSpacing.wide,
    ),
    labelMedium: TextStyle(
      color: textMuted,
      fontSize: FontSize.details,
      fontWeight: FontWeights.medium,
      letterSpacing: AppLetterSpacing.wide,
    ),
    labelSmall: TextStyle(
      color: textSubtle,
      fontSize: FontSize.caption,
      fontWeight: FontWeights.medium,
      letterSpacing: AppLetterSpacing.extraWide,
    ),
  );

  return ThemeData(
    fontFamily: 'Inter',
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: colorScheme.primary,
    cardColor: surfaceColor,
    dividerColor: dividerSubtle,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
      ),
      iconTheme: IconThemeData(color: onSurfaceColor),
      centerTitle: true,
      elevation: 0.0,
      scrolledUnderElevation: 4.0,
      backgroundColor: scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: onSurfaceColor,
        fontWeight: FontWeight.bold,
        fontSize: FontSize.subTitle + 1,
        letterSpacing: AppLetterSpacing.tight,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      surfaceTintColor: Colors.transparent,
      elevation: 2.0,
      shadowColor: AppColors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.cardAll,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surfaceColor,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      showDragHandle: true,
      dragHandleColor: dividerSubtle,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: textMuted,
      elevation: 16.0,
      type: BottomNavigationBarType.fixed,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return AppColors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withValues(alpha: 0.4);
        }
        return AppColors.grey.withValues(alpha: 0.4);
      }),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: onSurfaceColor,
      textColor: onSurfaceColor,
    ),
    textTheme: baseTextTheme,
    extensions: <ThemeExtension<dynamic>>[
      AppColorsExtension(
        green: AppColors.green,
        red: AppColors.red,
        purple: AppColors.purple,
        yellow: AppColors.yellow,
        darkGrey: AppColors.darkGrey,
        lightGrey: AppColors.lightGrey,
        grey: AppColors.grey,
        deepOrange: AppColors.deepOrange,
        blueGrey: AppColors.blueGrey,
        blue: AppColors.blue,
        white: AppColors.white,
        lightRed: AppColors.lightRed,
        darkBlue: AppColors.darkBlue,
        darkGreen: AppColors.darkGreen,
        blueGradient: AppColors.blueGradient,
        redGradient: AppColors.redGradient,
        surfaceGlass: surfaceGlass,
        surfaceElevated: surfaceElevated,
        textMuted: textMuted,
        textSubtle: textSubtle,
        dividerSubtle: dividerSubtle,
        onLive: AppColors.onLive,
        onScheduled: AppColors.onScheduled,
        onEnded: AppColors.onEnded,
        liveGradient: AppColors.liveGradient,
        accentGradient: AppColors.accentGradient,
      ),
    ],
  );
}
