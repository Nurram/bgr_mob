import 'package:bgr_logistik/models/item_search_response.dart';

import '../../core_imports.dart';

class HomeRepository {
  final _remoteDataSource = Get.find<RemoteDataSource>();

  Future<ItemSearchResponse> searchItem({required String query}) async {
    try {
      final response = await _remoteDataSource
          .post(endpoint: '/items/search', body: {'name': query});

      return ItemSearchResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
