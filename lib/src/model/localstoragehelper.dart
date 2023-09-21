import 'dart:convert';

import 'package:universal_html/html.dart';

class LocalStorageHelper {
  Storage localStorage = window.localStorage;

  void setValue(String key, String value) {
    localStorage[key] = value;
  }

  String? getValue(String key) {
    return localStorage[key];
  }

  void remove(String key) {
    localStorage.remove(key);
  }

  void clear() {
    localStorage.clear();
  }

  getUser(String key) {
    final user = localStorage[key];

    final obj = json.encode(user);
    print(obj);
  }
}
