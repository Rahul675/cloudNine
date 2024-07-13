import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();

  factory StorageService() {
    return instance;
  }

  StorageService._internal();

  final _box = GetStorage();

  Future<void> init() async {
    await GetStorage.init();
  }

  Future<void> setToken(String token) async {
    await _box.write('token', token);
  }

  String getToken() {
    return _box.read('token') ?? '';
  }

  Future<void> removeToken() async {
    await _box.remove('token');
  }
}
