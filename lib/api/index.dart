import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:voidlord/controller/auth_controller.dart';

var baseUrl = "http://192.168.151.111:3000/api/v1";

class Api {
  final Dio client = Dio();
  Api() {
    client.options.baseUrl = baseUrl;
    client.options.validateStatus = (status) {
      return true;
    };
    client.interceptors.add(AuthInterceptor());
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    AuthController authController = Get.find();
    final token = authController.token;
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
