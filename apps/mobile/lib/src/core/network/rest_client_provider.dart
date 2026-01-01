import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/app_config.dart';
import 'rest_client.dart';

final restClientProvider = Provider<RestClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final client = RestClient(baseUrl: config.restBaseUrl);
  ref.onDispose(client.dispose);
  return client;
});
