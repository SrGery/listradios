import 'dart:convert';
import 'package:listradios/models/radio_model.dart';
import 'package:listradios/services/client/api_provider.dart';

abstract class ApiClient {
  Future<List<RadioModel>> getRadioStations();
}

class OnApiClient implements ApiClient {
  final ApiProvider _apiProvider;

  OnApiClient({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<List<RadioModel>> getRadioStations() async {
    print("Hola");

    final response = await _apiProvider.get(
      path: 'stations',
      queryParameters: {'limit': '10', 'hidebroken': 'true', 'offset': '0'},
    );

    final decodedResponse = json.decode(response.body);

    return decodedResponse
        .map<RadioModel>(
          (radioStation) => RadioModel.fromJson(radioStation),
        )
        .toList();
  }
}
