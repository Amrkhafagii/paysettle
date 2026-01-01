import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paysettle_mobile/modules/wallet/presentation/pages/wallet_page.dart';
import 'package:paysettle_mobile/src/app.dart';
import 'package:paysettle_mobile/src/config/app_config.dart';
import 'package:paysettle_mobile/src/config/flavor.dart';
import 'package:paysettle_mobile/src/core/cache/cache_box.dart';
import 'package:paysettle_mobile/src/core/cache/cache_service.dart';
import 'package:paysettle_mobile/src/core/network/supabase_client_provider.dart';
import 'package:paysettle_mobile/src/navigation/app_router.dart';

void main() {
  testWidgets('renders PaySettleApp shell', (tester) async {
    final testRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const WalletPage(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              flavor: Flavor.dev,
              supabaseUrl: 'https://unit-test.supabase.co',
              supabaseAnonKey: 'anon-test',
              enableLogging: false,
              initialRoute: '/',
              restBaseUrl: 'https://api.test',
              sentryDsn: '',
            ),
          ),
          routerProvider.overrideWithValue(testRouter),
          supabaseClientProvider.overrideWithValue(
            SupabaseClient(
              'https://unit-test.supabase.co',
              'anon-test',
              authOptions: const AuthClientOptions(
                autoRefreshToken: false,
              ),
            ),
          ),
          cacheServiceProvider.overrideWithValue(_MemoryCacheService()),
        ],
        child: const PaySettleApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('My Wallet'), findsOneWidget);
  });
}

class _MemoryCacheService implements CacheService {
  final Map<CacheBox, Map<String, Object?>> _storage = {
    for (final box in CacheBox.values) box: <String, Object?>{},
  };

  @override
  Future<void> clear(CacheBox box) async {
    _storage[box]?.clear();
  }

  @override
  Future<void> delete(CacheBox box, String key) async {
    _storage[box]?.remove(key);
  }

  @override
  T? read<T>(CacheBox box, String key) {
    return _storage[box]?[key] as T?;
  }

  @override
  Future<void> write(CacheBox box, String key, Object? value) async {
    _storage[box]?[key] = value;
  }

  @override
  Future<void> init() async {}
}
