import 'package:global_configuration/global_configuration.dart';

class GlobalConfig {
  Future<void> setupConfiguration() async {
    await GlobalConfiguration().loadFromPath('config/config.json');
  }

  String get baseUrl {
    return GlobalConfiguration().get('base_url');
  }

  String get country {
    return GlobalConfiguration().get('country');
  }
}