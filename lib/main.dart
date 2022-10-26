import 'package:flutter/material.dart';
import 'package:forecast_pro/core/injection/injector.dart';
import 'package:forecast_pro/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  runApp(const MyApp());
}
