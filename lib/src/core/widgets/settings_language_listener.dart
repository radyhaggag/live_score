import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/settings/presentation/cubit/settings_cubit.dart';

/// A reusable listener that triggers [onLanguageChanged] when the app's language changes.
class SettingsLanguageListener
    extends BlocListener<SettingsCubit, SettingsState> {
  SettingsLanguageListener({
    super.key,
    required void Function(BuildContext context, SettingsState state)
    onLanguageChanged,
    super.child,
  }) : super(
         listenWhen:
             (previous, current) => previous.language != current.language,
         listener: onLanguageChanged,
       );
}
