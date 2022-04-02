import 'package:simplane_client_admin/generated/l10n.dart';

const EXCEPTION_CLIENT_SOCKET = 444;
const EXCEPTION_CLIENT_TIMEOUT = 445;
const EXCEPTION_CLIENT_UNKNOWN = 446;
const EXCEPTION_SERVER_OVERLOAD = 502;

class ApiException implements Exception {
  final String error;
  final int code;

  ApiException(this.error, this.code);

  @override
  String toString() {
    switch (code) {
      case EXCEPTION_CLIENT_SOCKET:
        return S.current.error_no_internet;
      case EXCEPTION_CLIENT_TIMEOUT:
        return S.current.error_timeout;
      default:
        return S.current.error;
    }
  }
}
