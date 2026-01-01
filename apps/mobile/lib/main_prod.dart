import 'bootstrap.dart';
import 'src/config/app_config.dart';

Future<void> main() async {
  await bootstrap(AppConfig.prod());
}
