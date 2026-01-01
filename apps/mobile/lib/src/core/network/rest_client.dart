import 'dart:convert';
import 'dart:io';

import 'network_exception.dart';

class RestClient {
  RestClient({required this.baseUrl, HttpClient? client})
      : _client = client ?? HttpClient();

  final String baseUrl;
  final HttpClient _client;

  Future<RestResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _send(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<RestResponse> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
  }) {
    return _send(
      method: 'POST',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
      body: body,
    );
  }

  Future<RestResponse> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
  }) {
    return _send(
      method: 'PUT',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
      body: body,
    );
  }

  Future<RestResponse> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
  }) {
    return _send(
      method: 'DELETE',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
      body: body,
    );
  }

  Future<RestResponse> _send({
    required String method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final base = Uri.parse(baseUrl);
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final qp = queryParameters == null
        ? null
        : Map.fromEntries(
            queryParameters.entries.where((entry) => entry.value != null).map(
                  (entry) => MapEntry(entry.key, entry.value.toString()),
                ),
          );
    final uri = base.replace(
      path: '${base.path}$normalizedPath',
      queryParameters: qp,
    );

    final request = await _client.openUrl(method, uri);
    headers?.forEach(request.headers.set);
    request.headers.contentType ??= ContentType.json;

    if (body != null) {
      request.add(utf8.encode(jsonEncode(body)));
    }

    final httpResponse = await request.close();
    final responseBody = await httpResponse.transform(utf8.decoder).join();
    final decoded = responseBody.isNotEmpty ? jsonDecode(responseBody) : null;

    if (httpResponse.statusCode >= 400) {
      throw NetworkException(
        'Request $method $path failed',
        statusCode: httpResponse.statusCode,
      );
    }

    return RestResponse(statusCode: httpResponse.statusCode, data: decoded);
  }

  void dispose() {
    _client.close(force: true);
  }
}

class RestResponse {
  RestResponse({required this.statusCode, this.data});

  final int statusCode;
  final dynamic data;
}
