import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

Widget viewAll(BuildContext context) => Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p8,
          bottom: AppPadding.p8,
          left: AppPadding.p20,
          right: AppPadding.p5),
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
    );
