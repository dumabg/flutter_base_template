import 'package:flutter/widgets.dart';
import 'package:flutter_utils/widgets/async_state.dart';
import 'package:intl/intl.dart';

import '../mixins/localization.dart';

class LocaleState extends InheritedWidget {
  final String currentLocale;

  const LocaleState({
    required super.child,
    required this.currentLocale,
    super.key,
  });

  @override
  bool updateShouldNotify(LocaleState oldWidget) {
    return oldWidget.currentLocale != currentLocale;
  }

  static LocaleState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleState>()!;
  }
}

class LocaleSwitcher extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  static final _localeKey = GlobalKey();
  LocaleSwitcher({required this.builder})
    : super(key: LocaleSwitcher._localeKey);

  static Future<void> changeLocale(String localeName) async {
    await (_localeKey.currentState! as _LocaleSwitcherState)._changeLocale(
      localeName,
    );
  }

  @override
  State<LocaleSwitcher> createState() => _LocaleSwitcherState();
}

class _LocaleSwitcherState extends AsyncState<LocaleSwitcher> {
  String _localeName = Intl.defaultLocale ?? '';

  @override
  Future<void> asyncInitState() async {
    await Localization.initWithLocale(_localeName);
  }

  Future<void> _changeLocale(String localeName) async {
    if (localeName != _localeName) {
      await Localization.initWithLocale(localeName);
      _rebuildAllChildren();
      setState(() {
        _localeName = localeName;
      });
    }
  }

  @override
  Widget buildWhenDone(BuildContext context) {
    return LocaleState(
      currentLocale: _localeName,
      child: Builder(builder: (context) => widget.builder(context)),
    );
  }

  void _rebuildAllChildren() {
    void rebuild(Element el) {
      el
        ..markNeedsBuild()
        ..visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
