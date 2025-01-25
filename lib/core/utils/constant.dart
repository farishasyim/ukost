import "package:dio/dio.dart";
import "package:ukost/core/utils/routes.dart";

Dio dio = Dio(
  BaseOptions(
    baseUrl: Routes.development,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
  ),
)..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print("Request: ${options.method} ${options.path}");
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print("Response: ${response.statusCode} ${response.data}");
      return handler.next(response);
    },
    onError: (error, handler) {
      print("Error: ${error.message}");
      return handler.next(error);
    },
  ));
