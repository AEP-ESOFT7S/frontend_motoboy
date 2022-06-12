import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli/app/data/models/api_response.dart';
import 'package:verydeli/app/data/provider/api_provider.dart';
import 'package:verydeli/app/modules/account/account_controller.dart';

class HomeRepository extends GetConnect {
  final APIProvider _restClient = APIProvider(url: 'https://merchant-api.ifood.com.br');

  final _storage = GetStorage();

  Future<ApiResponse> authorization() async {
    try {
      final credentials = await _storage.read('credentials');

      if (credentials == null) {
        throw RestClientException('Sistema ainda sem vinculo a um comercio!');
      }

      IFoodCredentials? credential = IFoodCredentials.fromJson(credentials);

      await _restClient
          .postApi(
        '/authentication/v1.0/oauth/token',
        {
          'grantType': 'client_credentials',
          'clientId': credential.clientId,
          'clientSecret': credential.clientSecret,
        },
        contentType: 'application/x-www-form-urlencoded',
      )
          .then((value) {
        if (value.statusCode == HttpStatus.ok) {
          return ApiResponse(result: value.body);
        } else {
          throw RestClientException('Falha ao registrar usuário!', code: value.statusCode);
        }
      }).catchError((_) {
        throw RestClientException('Falha ao registrar usuário!', code: _.statusCode);
      });
      throw RestClientException('');
    } on RestClientException catch (_) {
      throw RestClientException(_.message);
    }
  }

  Future<ApiResponse> polling(String token) async {
    try {
      token = _storage.read('accessToken') ?? '';

      final response = await _restClient.getApi('/order/v1.0/events:polling', headers: {
        'authorization': 'Bearer $token',
        'types': 'DSP',
      });

      if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.noContent) {
        throw RestClientException('Erro!', code: response.statusCode);
      }

      return ApiResponse(result: response.body);
    } on RestClientException catch (_) {
      throw RestClientException('Falha ao requisitar o polling!', code: _.code);
    }
  }
}
