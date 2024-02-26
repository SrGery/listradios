import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listradios/services/error/api_exceptions.dart';

abstract class ApiProvider {
  Future<http.Response> get({
    required String path,
    Map<String, String>? queryParameters = const {},
  });
}

class HttpApiRequester extends ApiProvider {
  final http.Client _client;
  final String _radioUrl;
  final String _country;

  HttpApiRequester({
    required http.Client client,
    required String radioUrl,
    required String country,
  })  : _client = client,
        _radioUrl = radioUrl,
        _country = country;

  @override
  Future<http.Response> get({
    required String path,
    Map<String, String>? queryParameters = const {},
  }) async {
    try {
      final uri = Uri.https(
        _radioUrl,
        '/$path',
        queryParameters,
      );

      final response = await _client.get(
        uri,
        headers: {
          "X-RapidAPI-Key":
              "fbbe52ed62msh22d7bec10539002p16d782jsne2bf1ec47066",
          "X-RapidAPI-Host": "bando-radio-api.p.rapidapi.com"
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ApiException();
      }
    } catch (e) {
      throw ApiException();
    }
  }
}
