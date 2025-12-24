import 'package:streamingo/modules/config/domain/enum_theme.dart';

class ConfigTheme {
  int? id;
  ThemeKind? theme;

  ConfigTheme({this.id, this.theme});

  int? get getId => id;
  ThemeKind? get getTheme => theme;

  set setId(int? id) => this.id = id;
  set setTheme(ThemeKind? theme) => this.theme = theme;
}
