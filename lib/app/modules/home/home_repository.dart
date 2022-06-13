import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli/app/data/models/api_response.dart';
import 'package:verydeli/app/data/provider/api_provider.dart';

class HomeRepository extends GetConnect {
  final APIProvider _restClient = APIProvider();

  final _storage = GetStorage();

  Future<ApiResponse> getDelivery() async {
    try {
      final response = await _restClient.getApi('/delivery');

      switch (response.statusCode) {
        case HttpStatus.ok:
          return ApiResponse();
        default:
          throw RestClientException('Falha ao registrar usuário!', code: response.statusCode);
      }
    } on RestClientException catch (_) {
      throw RestClientException(_.message, code: _.code);
    }
  }
}
