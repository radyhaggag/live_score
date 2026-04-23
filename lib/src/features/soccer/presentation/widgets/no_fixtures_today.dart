import 'package:flutter/material.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/utils/app_assets.dart';

class NoFixturesView extends StatelessWidget {
  const NoFixturesView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage(AppAssets.noFixtures)),
        Text(
          message ?? context.l10n.noFixtures,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
