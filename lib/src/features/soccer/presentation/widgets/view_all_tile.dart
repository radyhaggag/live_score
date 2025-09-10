import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class ViewAllTile extends StatelessWidget {
  final VoidCallback onTap;

  const ViewAllTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              AppStrings.viewAll,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 17,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
