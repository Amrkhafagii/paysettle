import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/config/app_config.dart';
import 'src/core/cache/cache_service.dart';
import 'src/core/cache/hive_cache_service.dart';
import 'src/core/observers/app_provider_observer.dart';
import 'src/core/reporting/error_reporter.dart';

/// Bootstraps the PaySettle application with the provided flavor config.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  _configureLogging(config.enableLogging);

  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabaseAnonKey,
  );

  final cacheService = HiveCacheService();
  await cacheService.init();

  final errorReporter = ErrorReporter();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorReporter.record(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorReporter.record(error, stack);
    return false;
  };

  Future<void> runApplication() async {
    runApp(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(config),
          cacheServiceProvider.overrideWithValue(cacheService),
          errorReporterProvider.overrideWithValue(errorReporter),
        ],
        observers: [AppProviderObserver(errorReporter)],
        child: const PaySettleApp(),
      ),
    );
  }

  final shouldEnableSentry = (config.sentryDsn ?? '').isNotEmpty;
  if (shouldEnableSentry) {
    await SentryFlutter.init(
      (options) {
        options.dsn = config.sentryDsn;
        options.environment = config.flavor.name;
        options.tracesSampleRate = config.enableLogging ? 1.0 : 0.2;
      },
      appRunner: () => runZonedGuarded(
          runApplication, (error, stack) => errorReporter.record(error, stack)),
    );
    return;
  }

  await runZonedGuarded(
      runApplication, (error, stack) => errorReporter.record(error, stack));
}

void _configureLogging(bool enableLogging) {
  Logger.root
    ..level = enableLogging ? Level.ALL : Level.WARNING
    ..onRecord.listen((record) {
      // ignore: avoid_print, logging is redirected for now
      // coverage:ignore-line
      print('[${record.level.name}] ${record.loggerName}: ${record.message}');
    });
}
