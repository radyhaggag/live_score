import 'package:flutter/material.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';

/// A team's logo inside a white circular avatar for the live fixture card.
class LiveTeamLogo extends StatelessWidget {
  const LiveTeamLogo({
    super.key,
    required this.logo,
    required this.radius,
    required this.imageSize,
  });

  final String logo;
  final double radius;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorsExt.white,
      radius: radius,
      child: CustomImage(width: imageSize, height: imageSize, imageUrl: logo),
    );
  }
}
