import 'package:get/get.dart';
import 'package:verydeli/app/core/settings/settings.dart';

class APIProvider extends GetConnect {
  APIProvider({String? url}) {
    httpClient.baseUrl = url ?? Settings.baseUrl;
  }

  // Future<Response> getApi(String path,
  //         {Map<String, String>? headers, Map<String, dynamic>? query}) =>
  //     get(path, headers: headers, query: query);

  // Future<Response> postApi(String path, dynamic data,
  //         {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query}) =>
  //     post(path, data, headers: headers, contentType: contentType, query: query);
}
