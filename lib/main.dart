import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/intl.dart';

import 'app.dart';
import 'services/errors/error_service.dart';

Future<void> main() async {
  usePathUrlStrategy();
  // runZonedGuarded is needed for catch async exceptions in web applications.
  // https://github.com/flutter/flutter/issues/100277
  await ErrorService.runInZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Intl.defaultLocale = 'pt';
    runApp(const App());
  });
}
