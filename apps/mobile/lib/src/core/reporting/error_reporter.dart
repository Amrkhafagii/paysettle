import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ErrorReporter {
  ErrorReporter({Logger? logger}) : _logger = logger ?? Logger('ErrorReporter');

  final Logger _logger;

  Future<void> record(
    Object error,
    StackTrace? stackTrace, {
    String? hint,
  }) async {
    _logger.severe(hint ?? 'Unhandled exception', error, stackTrace);

    if (Sentry.isEnabled) {
      await Sentry.captureException(error, stackTrace: stackTrace, hint: hint);
    }
  }
}

final errorReporterProvider = Provider<ErrorReporter>((ref) => ErrorReporter());
