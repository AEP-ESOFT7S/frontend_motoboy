import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli/app/data/models/api_response.dart';
import 'package:verydeli/app/data/provider/api_provider.dart';

class LoginRepository extends GetConnect {
  final APIProvider _restClient = APIProvider();

  final _storage = GetStorage();

  Future<ApiResponse> login(String email) async {
    try {
      final response = await _restClient.getApi('/register', query: {'email': email});

      switch (response.statusCode) {
        case HttpStatus.ok:
          for (var element in response.body) {
            String resultEmail = element['email'];
            String resultType = element['type'];
            if (resultEmail == email && resultType == 'motoboy') {
              await _storage.write('userData', jsonEncode(element));
              return ApiResponse();
            }
          }
          throw RestClientException('Usuário não cadastrado!', code: response.statusCode);

        default:
          throw RestClientException('Falha ao realizar login!', code: response.statusCode);
      }
    } on RestClientException catch (_) {
      throw RestClientException(_.message, code: _.code);
    }
  }
}
