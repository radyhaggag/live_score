import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_fonts.dart';

ThemeData getLightAppTheme() => _buildTheme(
  colorScheme: const ColorScheme.light(
    primary: AppColors.blue,
    secondary: AppColors.darkBlue,
    surface: AppColors.white,
    onSurface: AppColors.black,
  ),
  scaffoldBackgroundColor: AppColors.white,
  surfaceColor: AppColors.white,
  onSurfaceColor: AppColors.black,
  statusBarColor: AppColors.white,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

ThemeData getDarkAppTheme() => _buildTheme(
  colorScheme: const ColorScheme.dark(
    primary: AppColors.blue,
    secondary: AppColors.lightRed,
    surface: Color(0xFF181C24),
    onSurface: Color(0xFFF3F5F8),
  ),
  scaffoldBackgroundColor: const Color(0xFF10141B),
  surfaceColor: const Color(0xFF181C24),
  onSurfaceColor: const Color(0xFFF3F5F8),
  statusBarColor: const Color(0xFF10141B),
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

ThemeData _buildTheme({
  required ColorScheme colorScheme,
  required Color scaffoldBackgroundColor,
  required Color surfaceColor,
  required Color onSurfaceColor,
  required Color statusBarColor,
  required Brightness statusBarIconBrightness,
  required Brightness statusBarBrightness,
}) {
  final baseTextTheme = TextTheme(
    titleLarge: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.title,
      fontWeight: FontWeights.extraBold,
    ),
    titleMedium: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.subTitle,
      fontWeight: FontWeights.bold,
    ),
    titleSmall: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.bodyText,
      fontWeight: FontWeights.semiBold,
    ),
    bodyLarge: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.subTitle,
      fontWeight: FontWeights.semiBold,
    ),
    bodyMedium: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.bodyText,
      fontWeight: FontWeights.regular,
    ),
    bodySmall: const TextStyle(
      color: AppColors.white,
      fontSize: FontSize.details,
      fontWeight: FontWeights.medium,
    ),
    labelMedium: const TextStyle(
      color: AppColors.white,
      fontSize: FontSize.details,
      fontWeight: FontWeights.medium,
    ),
    headlineSmall: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.title,
      fontWeight: FontWeights.bold,
    ),
    displaySmall: TextStyle(
      color: onSurfaceColor,
      fontSize: FontSize.mainTitle,
      fontWeight: FontWeights.extraBold,
    ),
  );

  return ThemeData(
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: colorScheme.primary,
    cardColor: surfaceColor,
    dividerColor: onSurfaceColor.withValues(alpha: 0.12),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
      ),
      iconTheme: IconThemeData(color: onSurfaceColor),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: surfaceColor,
      titleTextStyle: TextStyle(
        color: onSurfaceColor,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
      surfaceTintColor: surfaceColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: AppColors.grey,
      elevation: 10.0,
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
  );
}
