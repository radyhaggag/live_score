import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'src/container_injector.dart';
import 'src/features/settings/presentation/cubit/settings_cubit.dart';
import 'src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initApp();
  await sl<SettingsCubit>().loadSettings();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
