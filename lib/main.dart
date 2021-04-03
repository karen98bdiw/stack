import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stack/app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitDown,
  ]);

  runApp(StackApp());
}

Future<void> main() async {
  await run();
}
