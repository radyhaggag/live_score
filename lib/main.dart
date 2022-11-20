import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'src/container_injector.dart';
import 'src/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
