import 'dart:convert';

import 'package:bots_app/utils/exceptions.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  static var client = http.Client();

  Future<dynamic> getCall(
    String url, {
    Map<String, dynamic> params,
    Map<String, String> headers,
    http.Client client,
    bool handleError = true,
  }) async {
    Map<String, String> requestHeaders = {};
    requestHeaders['Content-Type'] = 'application/json';

    final requestClient = client ?? HttpRequest.client;
    return requestClient
        .get(url, headers: requestHeaders)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode < 200 || statusCode >= 400) {
        if (handleError) {
          try {
            throw APIException.fromJson(json.decode(response.body), statusCode);
          } on FormatException {
            throw APIException.generic;
          }
        } else {
          if (response.bodyBytes == null || response.bodyBytes.isEmpty)
            throw APIException.generic;
          try {
            throw json.decode(json.decode(response.body));
          } on FormatException {
            throw APIException.generic;
          }
        }
      }

      if (response.bodyBytes == null || response.bodyBytes.isEmpty) return null;

      return json.decode(response.body);
    });
  }
}
