import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  writeSourceData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    return await storage.read(key: key) ?? '';
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}