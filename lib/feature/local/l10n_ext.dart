import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';


extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  String errorText(String raw) {
    final t = l10n;
    switch (raw) {
      case 'network':
        return t.errNetwork;
      case 'timeout':
        return t.errTimeout;
      case 'canceled':
        return t.errCanceled;
      case 'unauthorized':
        return t.errUnauthorized;
      case 'not-found':
        return t.errNotFound;
      case 'forbidden':
        return t.errForbidden;
      case 'server':
        return t.errServer;
      case 'bad-request':
        return t.errBadRequest;
      case 'unexpected':
        return t.errUnexpected;
      case 'google-cancelled':
        return t.errGoogleCancelled;
      case 'no-user':
        return t.errNoUser;
    // FirebaseAuthException.code values
      case 'user-not-found':
        return t.errUserNotFound;
      case 'wrong-password':
        return t.errWrongPassword;
      case 'invalid-credential':
        return t.errInvalidCredential;
      case 'email-already-in-use':
        return t.errEmailInUse;
      case 'weak-password':
        return t.errWeakPassword;
      case 'invalid-email':
        return t.errInvalidEmail;
      case 'too-many-requests':
        return t.errTooManyRequests;
      case 'network-request-failed':
        return t.errNetwork;
      default:
        return raw;
    }
  }
}