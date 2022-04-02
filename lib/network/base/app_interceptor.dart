import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/utils.dart';

class LoggingInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(options, handler) async {
    final log = StringBuffer();
    log.write(
        '--> ${!isNullOrEmpty(options.method) ? options.method.toUpperCase() : 'METHOD'} ${"" + options.baseUrl + options.path}\nHEADERS: ');
    options.headers.forEach((k, v) => log.write('$k: $v; '));
    if (!isNullOrEmpty(options.queryParameters)) {
      log.write("\nPARAMS: ");
      options.queryParameters.forEach((k, v) => log.write('$k: $v; '));
    }
    if (!isNullOrEmpty(options.data)) {
      try {
        final responseDataJson = json.encode(options.data);
        final logList = splitByLength(responseDataJson, 900);
        if (!isNullOrEmpty(logList)) {
          log.write('\nBODY:');
          if (responseDataJson.length > 3000) {
            log.write('\n$responseDataJson');
          } else {
            final logList = splitByLength(responseDataJson, 900);
            if (!isNullOrEmpty(logList)) {
              logList.forEach((it) => log.write('\n$it'));
            }
          }
        }
      } catch (e) {
        log.write('\nBODY: Cannot convert to JSON');
      }
    }
    log.write(
        "\n--> END ${!isNullOrEmpty(options.method) ? options.method.toUpperCase() : 'METHOD'}");
    Logger.i(log.toString());
    return super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onError(err, handler) async {
    Logger.e(
      err.requestOptions.path,
      '[${err.response?.statusCode}] - ${err.response?.headers ?? ''}\n${err.error}',
    );
    return super.onError(err, handler);
  }

  @override
  Future<dynamic> onResponse(response, handler) async {
    final log = StringBuffer();
    log.write(
        "<-- ${response.statusCode} ${(!isNullOrEmpty(response.requestOptions.path) ? '${response.requestOptions.baseUrl}${response.requestOptions.path}' : 'URL')}");
    log.write("\nHEADERS: ");
    response.headers.forEach((k, v) => log.write('$k: $v; '));
    if (!isNullOrEmpty(response.data)) {
      try {
        final responseDataJson = json.encode(response.data);
        log.write('\nRESPONSE:');
        if (responseDataJson.length > 3000) {
          log.write('\n$responseDataJson');
        } else {
          final logList = splitByLength(responseDataJson, 900);
          if (!isNullOrEmpty(logList)) {
            logList.forEach((it) => log.write('\n$it'));
          }
        }
      } catch (e) {
        log.write('\nRESPONSE: Cannot convert to JSON');
      }
    }
    log.write("\n<-- END HTTP");
    Logger.d(log.toString());
    return super.onResponse(response, handler);
  }
}
