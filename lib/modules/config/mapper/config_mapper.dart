import 'package:streamingo/modules/config/domain/config_theme.dart';
import 'package:streamingo/modules/config/domain/enum_theme.dart';

class ConfigMapper {
  static ConfigTheme fromMap(Map<String, dynamic> map) {
    return ConfigTheme(
      id: map['id'],
      theme:
          map['theme'] != null ? ThemeKind.values[map['theme'] as int] : null,
    );
  }

  static Map<String, dynamic> toMap(ConfigTheme configTheme) {
    return {'id': configTheme.getId, 'theme': configTheme.getTheme?.index};
  }
}
