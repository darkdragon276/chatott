// main.dart
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'presentation/app.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  initializeDateFormatting().then((_) => runApp(const App()));

}
