import 'package:get/get.dart';
import 'package:verydeli/app/data/models/api_response.dart';
import 'package:verydeli/app/data/models/register_request.dart';
import 'package:verydeli/app/data/provider/api_provider.dart';

class RegisterRepository extends GetConnect {
  final APIProvider _restClient = APIProvider();

  Future<ApiResponse> register(RegisterRequest registerData) async {
    try {
      final response = await _restClient.postApi('/register', registerData.toJson());
      return ApiResponse(message: '');
    } catch (e) {
      return ApiResponse(message: '');
    }
  }
}
