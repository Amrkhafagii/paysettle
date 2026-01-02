import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flavor.dart';

class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.enableLogging,
    required this.initialRoute,
    required this.restBaseUrl,
    this.showDebugBanner = false,
    this.sentryDsn,
  });

  factory AppConfig.dev() => AppConfig(
        flavor: Flavor.dev,
        supabaseUrl: 'https://jzfhytosexjlurjhltkn.supabase.co',
        supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6Zmh5dG9zZXhqbHVyamhsdGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcxOTgxMTMsImV4cCI6MjA4Mjc3NDExM30.N_MZqND2Aa51HEKFBK8GXtlLMJAywYHEOf3WmFFaQR8',
        enableLogging: true,
        initialRoute: '/onboarding',
        restBaseUrl: 'https://api.dev.paysettle.local',
        sentryDsn: '',
        showDebugBanner: true,
      );

  factory AppConfig.stg() => AppConfig(
        flavor: Flavor.stg,
        supabaseUrl: 'https://stg-placeholder.supabase.co',
        supabaseAnonKey: 'public-anon-key-stg',
        enableLogging: true,
        initialRoute: '/onboarding',
        restBaseUrl: 'https://api.stg.paysettle.local',
        sentryDsn: '',
      );

  factory AppConfig.prod() => AppConfig(
        flavor: Flavor.prod,
        supabaseUrl: 'https://prod-placeholder.supabase.co',
        supabaseAnonKey: 'public-anon-key-prod',
        enableLogging: false,
        initialRoute: '/onboarding',
        restBaseUrl: 'https://api.paysettle.com',
        sentryDsn: '',
      );
  final Flavor flavor;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool enableLogging;
  final String initialRoute;
  final bool showDebugBanner;
  final String restBaseUrl;
  final String? sentryDsn;
}

final appConfigProvider =
    Provider<AppConfig>((ref) => throw UnimplementedError());
