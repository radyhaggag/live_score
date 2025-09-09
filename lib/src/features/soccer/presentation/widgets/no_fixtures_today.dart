import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';

class NoFixturesView extends StatelessWidget {
  const NoFixturesView({super.key, this.message = AppStrings.noFixtures});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage(AppAssets.noFixtures)),
        Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
