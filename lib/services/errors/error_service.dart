// ignore_for_file: avoid_annotating_with_dynamic
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_utils/services/toast_service.dart';
import 'package:flutter_utils/widgets/async_state.dart';
import 'app_controlled_errors.dart';
import 'controlled_error.dart';

class ErrorService {
  static List<ControlledError> _controlledErrors = [];
  static dynamic _lastError;

  static Future<void> initialize(List<ControlledError> controlledErrors) async {
    _controlledErrors = controlledErrors;

    FlutterError.onError = _dispatchFlutterError;
    PlatformDispatcher.instance.onError = _dispatchPlatformDispatcherError;
    AsyncState.onError = _dispatchAsyncStateError;
  }

  static void _dispatchFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.presentError(details);
      print(details);
    } else {
      final exception = details.exception;
      _dispatch(exception, details.stack);
    }
  }

  static bool _dispatchPlatformDispatcherError(Object error, StackTrace stack) {
    if (kDebugMode) {
      print(error);
      print(stack);
    }
    _dispatch(error, stack);
    return false;
  }

  static void _dispatchAsyncStateError(Object error, StackTrace? stack) {
    if (kDebugMode) {
      print(error);
      print(stack);
    }
    _dispatch(error, stack);
  }

  static void _dispatch(dynamic error, StackTrace? stack) {
    if (!_isControlledError(error)) {
      if (_lastError != error) {
        _lastError = error;
        ToastService.showError(error);
      }
    }
  }

  static bool _isControlledError(dynamic error) {
    for (final ControlledError controlledError in _controlledErrors) {
      if (controlledError(error)) {
        return true;
      }
    }
    return false;
  }

  /// runZonedGuarded is needed for catch async exceptions in web applications.
  /// https://github.com/flutter/flutter/issues/100277
  /// Exemple:
  /// await ErrorService.runInZonedGuarded(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await FirebaseConfig.init();
  //   await Localization.initWithLocale('pt');
  //   runApp(const MyApp());
  // });
  static Future<void> runInZonedGuarded(Future<void> Function() f) async {
    await initializeErrorService();
    await runZonedGuarded<Future<void>>(
      () async {
        await f();
      },
      // ignore: unnecessary_lambdas
      (Object error, StackTrace stack) {
        // WARNING, if put directly the method like a lambda, the method
        // isn't called.
        _dispatchPlatformDispatcherError(error, stack);
      },
    );
  }
}
