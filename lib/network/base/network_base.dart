// Pub: power_base
// Author: Hồ Hoàng Hải
// Changes: Migrated to null safety

class NetworkBase {
  static final NetworkBase _networkBase = NetworkBase._internal();
  factory NetworkBase() => _networkBase;
  static NetworkBase get instance => _networkBase;
  NetworkBase._internal() {
    apiTimeoutMillis = 18000;
    customApiHeader = {};
  }

  late int apiTimeoutMillis;
  late Map<String, dynamic> customApiHeader;

  init(int? apiTimeoutMillis, Map<String, dynamic>? customApiHeader) {
    this.apiTimeoutMillis = apiTimeoutMillis ?? this.apiTimeoutMillis;
    this.customApiHeader = customApiHeader ?? this.customApiHeader;
  }

  setApiHeaders(Map<String, dynamic> customApiHeader) {
    this.customApiHeader = customApiHeader;
  }

  addApiHeaders(Map<String, dynamic> customApiHeader) {
    this.customApiHeader.addAll(customApiHeader);
  }

  removeApiHeaders(String key) => customApiHeader.remove(key);
}
