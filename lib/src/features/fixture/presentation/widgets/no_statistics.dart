import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/app_empty.dart';

/// Shown when no statistics are available for the selected fixture.
class NoStatistics extends StatelessWidget {
  const NoStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: AppEmptyWidget(
        message: context.l10n.noStats,
        icon: PhosphorIcons.chartBar(PhosphorIconsStyle.regular),
        color: context.colorsExt.blueGrey,
      ),
    );
  }
}
