import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc_observer.dart';
import 'src/container_injector.dart';
import 'src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initApp();
  Bloc.observer = MyBlocObserver();
  await loadEnvFiles();
  runApp(const MyApp());
}

Future<void> loadEnvFiles() async {
  // Load environment variables from .env files
  // This is a placeholder for the actual implementation
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    log("An error occurred during load the .env file");
  }
}
