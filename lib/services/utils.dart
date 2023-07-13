import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class Utils {
  Utils(this.context);
  BuildContext context;

  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.white : Colors.black;
}
