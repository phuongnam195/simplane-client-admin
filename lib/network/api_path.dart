import 'package:simplane_client_admin/util/utils.dart';

import 'base/api_client.dart';

const DOMAIN = 'http://localhost:8282/simplane-service'; //Temporary
const URL = DOMAIN;

const LOGIN = '$URL/auth/sign-in';
const SIGNUP = '$URL/auth/sign-up';
const LOGOUT = '$URL/auth/sign-out';

const FLIGHT = '$URL/flight';

const TICKET = '$URL/ticket';

const AIRPORT = '$URL/air-port';

const LIST_AIRPORT = '$URL/air-port/list';

const REPORT_GET = '$URL/report';

const STAFF = '$URL/staff';

const RULE = '$URL/rule';

const TICKET_CLASS_GETS = '$URL/ticket-class';

Future<List<dynamic>> getListFromApi(
    {required String apiUrl, Map<String, dynamic>? customQuery}) async {
  return await ApiClient(getUrlWithQuery(apiUrl, query: customQuery)).get();
}
