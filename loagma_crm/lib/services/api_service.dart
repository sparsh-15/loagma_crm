import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class ApiService {
  // If you're running on a real Android device, set this to your PC's LAN IP (e.g. 192.168.x.x).
  // For Android emulator use 10.0.2.2, for Genymotion use 10.0.3.2. For iOS simulator and web use localhost.
  static const String _hostIp = '192.168.1.6';

  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:5000';
    try {
      if (Platform.isAndroid) {
        // Android emulator maps host localhost to 10.0.2.2
        return 'http://10.0.2.2:5000';
      }
      // iOS simulator / desktop will be able to access host via localhost or LAN IP
      return 'http://$_hostIp:5000';
    } catch (_) {
      // Fallback when Platform is not available (tests, other targets)
      return 'http://$_hostIp:5000';
    }
  }

  static Future<Map<String, dynamic>> sendOtp(String contactNumber) async {
    final url = Uri.parse('$baseUrl/auth/send-otp');

    final response = await http
        .post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"contactNumber": contactNumber}), 
    )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to send OTP: ${response.body}");
    }
  }

}
