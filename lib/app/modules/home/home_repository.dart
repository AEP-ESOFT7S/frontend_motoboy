import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:verydeli/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli/app/data/models/api_response.dart';
import 'package:verydeli/app/data/provider/api_provider.dart';

class HomeRepository extends GetConnect {
  Future<ApiResponse> getRoute(String latLongInitial, String latLongFinal, String token) async {
    final APIProvider restClientRoute = APIProvider(
      url: 'https://api.mapbox.com/directions/v5/mapbox/driving',
    );

    try {
      final response = await restClientRoute.get(
        '/$latLongInitial;$latLongFinal',
        query: {
          'alternatives': 'true',
          'geometries': 'geojson',
          'overview': 'simplified',
          'steps': 'false',
          'access_token': token,
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          return ApiResponse(result: response.body["routes"][0]["geometry"]["coordinates"]);
        default:
          throw RestClientException('Falha ao calcular rota!', code: response.statusCode);
      }
    } on RestClientException catch (_) {
      throw RestClientException(_.message, code: _.code);
    }
  }
}
