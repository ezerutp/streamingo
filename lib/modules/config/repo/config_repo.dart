import 'package:streamingo/modules/config/domain/config_theme.dart';
import 'package:streamingo/modules/config/mapper/config_mapper.dart';
import 'package:streamingo/persistence/db.dart';

class ConfigRepo {
  Future<ConfigTheme?> getConfigTheme() async {
    final db = await DatabaseService().database;
    final result = await db.query('config_theme', limit: 1);
    if (result.isNotEmpty) {
      return ConfigMapper.fromMap(result.first);
    }
    return null;
  }

  Future<void> saveConfigTheme(ConfigTheme configTheme) async {
    final db = await DatabaseService().database;
    await db.insert('config_theme', ConfigMapper.toMap(configTheme));
  }
}
