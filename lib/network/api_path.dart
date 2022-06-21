import 'package:simplane_client_admin/util/utils.dart';

import 'base/api_client.dart';

const DOMAIN = 'http://localhost:8282/simplane-service'; //Temporary
const URL = DOMAIN;

const LOGIN = '$URL/auth/sign-in';
const SIGNUP = '$URL/auth/sign-up';
const LOGOUT = '$URL/auth/sign-out';

const FLIGHT_GET = '$URL/flight';

const TICKET_GET = '$URL/ticket/get';
const TICKET_GETS = '$URL/ticket/gets';

const REPORT_GET = '$URL/report/get';

const TICKET_CLASS_GETS = '$URL/ticket-class/gets';

Future<List<dynamic>> getListFromApi(
    {required String apiUrl, Map<String, dynamic>? customQuery}) async {
  return await ApiClient(getUrlWithQuery(apiUrl, query: customQuery)).get();
}
