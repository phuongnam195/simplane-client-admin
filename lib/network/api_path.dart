import 'package:simplane_client_admin/util/utils.dart';

import 'base/api_client.dart';

const DOMAIN = 'https://heroku.com'; //Temporary
const URL = DOMAIN;

const LOGIN = '$URL/api/auth/login';
const SIGNUP = '$URL/api/auth/signup';
const LOGOUT = '$URL/api/auth/logout';

const FLIGHT_GET = '$URL/api/flight/get';
const FLIGHT_GETS = '$URL/api/flight/gets';

const TICKET_GET = '$URL/api/ticket/get';
const TICKET_GETS = '$URL/api/ticket/gets';

const TICKET_CLASS_GETS = '$URL/api/ticket-class/gets';

Future<List<dynamic>> getListFromApi(
    {required String apiUrl, Map<String, dynamic>? customQuery}) async {
  return await ApiClient(getUrlWithQuery(apiUrl, query: customQuery)).get();
}
