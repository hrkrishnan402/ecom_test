import 'dart:convert';

import 'package:http/http.dart' as http;

/// Thin HTTP wrapper so the data layer never imports `http` directly.
class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  /// GET [url] and return the decoded JSON body.
  ///
  /// Throws [ApiException] on non-200 responses or network errors.
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
      throw ApiException(
        'Failed to load data',
        statusCode: response.statusCode,
      );
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: $e');
    }
  }

  void dispose() => _client.close();
}

/// Custom exception for API errors.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}
