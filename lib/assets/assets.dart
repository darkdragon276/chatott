import 'dart:convert';

import 'package:flutter/services.dart' as root_bundle;

class Assets {
  static Future<String> getAssets(String key) async {
    final jsondata =
        await root_bundle.rootBundle.loadString("./lib/assets/images.json");
    Map assets = json.decode(jsondata) as Map;

    return assets[key].toString();
  }
}
