import 'package:flutter/material.dart';
import 'package:flutter_utils/services/toast_service.dart';
import 'package:flutter_utils/util/navigator_of.dart';
import 'package:flutter_utils/widgets/async_state.dart';

import 'l10n/app_localizations.dart';
import 'main_unexpected_error_widget.dart';
import 'screens/home_screen.dart';
import 'widgets/locale_switcher.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends AsyncState<App> {
  @override
  Future<void> asyncInitState() async {}

  @override
  Widget buildWhenDone(BuildContext context) {
    return LocaleSwitcher(
      builder:
          (context) => MaterialApp(
            scaffoldMessengerKey: ToastService.scaffoldMessengerKey,
            navigatorKey: NavigatorOf.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Crexga', // spell-checker: disable-line
            home: const HomeScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(LocaleState.of(context).currentLocale),
          ),
    );
  }

  @override
  Widget buildWhenError(BuildContext context) =>
      MainUnexpectedErrorWidget(error: null);
}
