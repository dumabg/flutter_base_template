// ignore_for_file: avoid_annotating_with_dynamic

import 'dart:async';
import 'error_service.dart';

Future<void> initializeErrorService() async {
  await ErrorService.initialize([_isAssertErrorControlled, _isErrorControlled]);
}

bool _isAssertErrorControlled(dynamic e) {
  final String msg = e.message.toString();
  return

      /// Flutter bug. AssertionError when AltGr is pressed
      ///   'A KeyUpEvent is dispatched ...'
      /// Other errors with keyboard:
      ///   'Attempted to send a key down event when no keys are
      ///   in keysPressed...'
      /// ' _dispatchKeyData == null '
      msg.contains('Key');
}

bool _isErrorControlled(dynamic error) {
  // When a url with uri is launched, appears this error, because no routes
  // are specified. For example, when the web is accessed with a link
  // created for an external provider: /experience?p=<provider id>&id=eQ3hjXMgqUunDJFJMsYO  cSpell:disable-line
  //
  // Error:
  //Could not navigate to initial route.
  // The requested route name was:
  // "/experience?p=test&id=eQ3hjXMgqUunDJFJMsYO"  cSpell:disable-line
  // There was no corresponding route in the app, and therefore the
  // initial route specified will be ignored and "/" will be used
  // instead.
  return error.toString().startsWith('Could not navigate to initial route');
}
