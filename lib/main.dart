import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc_observer.dart';
import 'src/container_injector.dart';
import 'src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initApp();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
