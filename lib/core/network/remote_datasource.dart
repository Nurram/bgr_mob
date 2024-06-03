import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core_imports.dart';

class RemoteDataSource {
  late Dio _dio;

  RemoteDataSource() {
    final token = Get.find<AuthController>().token;
    final headers = {
      "accept": "application/json",
      "content-type": "application/json",
      "Authorization": token.value,
    };

    _dio = Dio(
      BaseOptions(baseUrl: dotenv.env['BASE_URL']!, headers: headers),
    )..interceptors.addAll([
        PrettyDioLogger(requestHeader: true, requestBody: true),
      ]);
  }

  Future<Response> get({required String endpoint}) async {
    try {
      await _setToken();

      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) handleUnauthorized();

      throw e.response?.data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
      {required String endpoint, required dynamic body, bool noPop = false}) async {
    try {
      await _setToken();

      final response = await _dio.post(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401 && !noPop) handleUnauthorized();

      throw e.response?.data['message'];
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Response> delete(
      {required String endpoint, required dynamic body}) async {
    try {
      await _setToken();

      final response = await _dio.delete(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) handleUnauthorized();

      throw e.response?.data['message'];
    } catch (e) {
      rethrow;
    }
  }

  _setToken() async {
    final token = await Get.find<AuthController>().getToken();

    if (token != null && token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
