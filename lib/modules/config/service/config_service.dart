import 'package:streamingo/modules/config/repo/config_repo.dart';
import 'package:streamingo/modules/config/domain/config_theme.dart';

class ConfigService {
  final ConfigRepo configRepo;

  ConfigService({required this.configRepo});

  Future<ConfigTheme?> getConfigTheme() async {
    return configRepo.getConfigTheme();
  }

  Future<void> saveConfigTheme(ConfigTheme configTheme) async {
    await configRepo.saveConfigTheme(configTheme);
  }
}
