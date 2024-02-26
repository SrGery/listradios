import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:listradios/models/data/equal.dart';
import 'package:listradios/models/data/error/fails.dart';
import 'package:listradios/models/data/radio.dart';
import 'package:listradios/services/client/api_client.dart';
import 'package:listradios/services/error/api_exceptions.dart';

abstract class RadioRepository {
  Future<Equal<List<Radios>>> getRadioStations();
}

class ImplementRadioRepository extends RadioRepository {
  final ApiClient _apiClient;

  ImplementRadioRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<Equal<List<Radios>>> getRadioStations() async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final result = await _apiClient.getRadioStations();

        return Equal.success(result);
      } on ApiException {
        return Equal.error(ServerFailure());
      }
    } else {
      return Equal.error(NetworkFailure());
    }
  }
}
