import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:verydeli/app/core/settings/settings.dart';

class APIProvider extends GetConnect {
  // final _storageAuth = GetStorage();

  APIProvider({String? url}) {
    httpClient.baseUrl = url ?? Settings.baseUrl + Settings.id;
  }

  Future<Response> getApi(String path,
          {Map<String, String>? headers, Map<String, dynamic>? query}) =>
      get(path, headers: headers, query: query);

  Future<Response> postApi(String path, dynamic data,
          {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query}) =>
      post(path, data, headers: headers, contentType: contentType, query: query);
}
