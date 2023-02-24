import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  Future<String> readSecureData(String key) async {
    _storage.delete(key: 'token');
    String value = "";
    try {
      value = (await _storage.read(
          key: key,
          aOptions: _getAndroidOptions())) ?? "";
    } catch (e) {
      print(e);
    }
    return value;
  }

  void writeSecureData(String key, String value) async {
    try {
      await _storage.write(
        key: key,
        value: value,
        aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteSecureData(String key) async {
    try {
      await _storage.delete(
          key: key,
          aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      print(e);
    }
  }

  AndroidOptions _getAndroidOptions() => AndroidOptions(
    encryptedSharedPreferences: true,
  );
}

final secureStorage = SecureStorage();