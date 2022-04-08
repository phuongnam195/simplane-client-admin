import 'package:simplane_client_admin/network/base/api_client.dart';
import 'package:simplane_client_admin/util/utils.dart';

abstract class BaseRepository<T> {
  Future<dynamic> getFromApi({
    required String apiUrl,
    Map<String, dynamic>? customQuery,
  });

  Future<List<dynamic>> getListFromApi({
    required String apiUrl,
    Map<String, dynamic>? customQuery,
  });
}

class BaseRepositoryImp<T> implements BaseRepository<T> {
  @override
  Future<dynamic> getFromApi(
      {required String apiUrl, Map<String, dynamic>? customQuery}) async {
    return await ApiClient(getUrlWithQuery(apiUrl, query: customQuery)).get();
  }

  @override
  Future<List<dynamic>> getListFromApi(
      {required String apiUrl, Map<String, dynamic>? customQuery}) async {
    return await ApiClient(getUrlWithQuery(apiUrl, query: customQuery)).get();
  }
}
