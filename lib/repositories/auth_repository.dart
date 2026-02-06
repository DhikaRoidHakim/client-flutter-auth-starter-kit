import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class AuthRepository {
  // Ganti URL sesuai dengan IP address server (gunakan IP lokal komputer jika di emulator)
  // Untuk Android Emulator: 10.0.2.2
  // Untuk iOS Simulator: 127.0.0.1
  // Gunakan 10.0.2.2 untuk Android Emulator agar bisa akses localhost komputer
  // Gunakan 127.0.0.1 untuk iOS Simulator
  static const String baseUrl = 'http://192.168.4.236:8000/api';

  final http.Client _httpClient;

  AuthRepository({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final deviceInfo = await _getDeviceInfo();

    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': deviceInfo['device_name'],
          'device_os': deviceInfo['device_os'],
          'device_identifier': deviceInfo['device_identifier'],
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return data['data'];
      } else {
        throw Exception(data['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> logout() async {
    final secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return;
      } else {
        throw Exception(data['message'] ?? 'Logout failed');
      }
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = 'Unknown';
    String deviceOs = 'Unknown';
    String deviceIdentifier = 'unknown_id';

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = '${androidInfo.manufacturer} ${androidInfo.model}';
        deviceOs = 'Android ${androidInfo.version.release}';
        deviceIdentifier = androidInfo.id; // UUID or unique ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.name;
        deviceOs = '${iosInfo.systemName} ${iosInfo.systemVersion}';
        deviceIdentifier = iosInfo.identifierForVendor ?? 'unknown_ios_id';
      }
    } catch (e) {
      // Fallback for web or other platforms if needed
      deviceName = 'Flutter App';
      deviceOs = Platform.operatingSystem;
    }

    return {
      'device_name': deviceName,
      'device_os': deviceOs,
      'device_identifier': deviceIdentifier,
    };
  }
}
