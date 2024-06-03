import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/models/uoms_response.dart';

class UomRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<UomsResponse> getDatas() async {
    try {
      final response = await _remoteDataSource.get(endpoint: '/uoms');

      return UomsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  insert({required String name}) async {
    try {
      await _remoteDataSource
          .post(endpoint: '/uoms/insert', body: {'name': name});
    } catch (e) {
      rethrow;
    }
  }

  update({required int id, required String name}) async {
    try {
      await _remoteDataSource.post(endpoint: '/uoms/update', body: {
        'id': id,
        'name': name,
      });
    } catch (e) {
      rethrow;
    }
  }

  delete({required int id}) async {
    try {
      await _remoteDataSource
          .delete(endpoint: '/uoms/delete', body: {'id': id});
    } catch (e) {
      rethrow;
    }
  }
}
