import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

mixin Localization {
  static AppLocalizations? _l;
  static AppLocalizations get l => _l!;

  AppLocalizations get loc => Localization.l;

  static void init(BuildContext context) => _l = AppLocalizations.of(context)!;

  static Future<void> initWithLocale(String localeName) async =>
      _l = await AppLocalizations.delegate.load(Locale(localeName));

  static Future<void> initDefaultLocale() async {
    _l = await AppLocalizations.delegate.load(
      Locale(Intl.defaultLocale ?? 'pt'),
    );
  }
}
