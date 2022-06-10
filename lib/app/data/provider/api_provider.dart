import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:verydeli/app/core/settings/settings.dart';

class APIProvider extends GetConnect {
  // final _storageAuth = GetStorage();

  APIProvider() {
    httpClient.baseUrl = Settings.baseUrl;
  }

  Future<Response> getApi(String path) => get(Settings.api + path);

  Future<Response> postApi(String path, dynamic data, {Map<String, String>? headers}) =>
      post(Settings.api + Settings.id + path, data, headers: headers);
}
