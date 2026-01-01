import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../reporting/error_reporter.dart';

class AppProviderObserver extends ProviderObserver {
  AppProviderObserver(this._reporter);

  final ErrorReporter _reporter;
  final Logger _logger = Logger('ProviderObserver');

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    _logger.fine('Provider ${provider.name ?? provider.runtimeType} changed');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  @override
  void handleError(
      ProviderBase<Object?> provider, Object error, StackTrace stackTrace) {
    _reporter.record(error, stackTrace,
        hint: 'Provider ${provider.name ?? provider.runtimeType} error');
    super.handleError(provider, error, stackTrace);
  }
}
