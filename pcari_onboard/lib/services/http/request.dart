import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pcari_onboard/model/response.dart';
class PostmanRequest {

  static const String host = 'reqres.in';

  static Future<ResponseOrError> getResponse({
    int? page
  }) async {
    String? anyError;
    try {
      http.Response response = await http.get(Uri(
        scheme: 'https',
        host: host,
        path: 'api/users',
        queryParameters: {'page': '${page ?? 1}'},
      )).timeout(Duration(seconds: 7));
      if (response.statusCode == 200) {
        PostmanResponse postmanResponse = PostmanResponse.fromJson(response.body);
        if (postmanResponse.data == null || postmanResponse.data!.isEmpty) {
          anyError = 'Response data is empty.';
        } else {
          return ResponseOrError(response: postmanResponse);
        }
        // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // dateTime = DateTime.parse(jsonResponse['datetime']);
      } else {
        anyError = 'Response status is ${response.statusCode}.';
      }
    } catch (e) {
      debugPrint('ERROR getResponse() : $e');
      anyError = e.toString();
    }
    return ResponseOrError(anyError: anyError);
  }
}