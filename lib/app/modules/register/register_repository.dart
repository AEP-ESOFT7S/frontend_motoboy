import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:verydeli/app/data/models/api_response.dart';
import 'package:verydeli/app/data/provider/api_provider.dart';

class RegisterRepository extends GetConnect {
  final APIProvider _restClient = APIProvider();

  Future<ApiResponse<String>> register(String registerData) async {
    try {
      final response = await _restClient.postApi('/register', registerData);

      if (response.statusCode == HttpStatus.created) {
        return ApiResponse(message: 'Usuário registrado com sucesso!');
      }
      return ApiResponse(message: 'Falha ao registrar usuário!');
    } catch (e) {
      return ApiResponse(message: '');
    }
  }
}
