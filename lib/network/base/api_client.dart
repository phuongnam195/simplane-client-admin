import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/utils.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'api_exception.dart';
import 'app_interceptor.dart';
import 'base_response.dart';

enum ApiMethod { get, post, put, delete, upload }

class ApiClient {
  final String url;
  final dio = Dio();

  ApiClient(this.url, {Map<String, String>? headers}) {
    dio.interceptors.add(LoggingInterceptors());
    dio.options.connectTimeout = NetworkBase.instance.apiTimeoutMillis;
    dio.options.receiveTimeout = NetworkBase.instance.apiTimeoutMillis;

    if (headers == null || headers.isNotEmpty) {
      dio.options.contentType = Headers.jsonContentType;
      if (!isNullOrEmpty(NetworkBase.instance.customApiHeader)) {
        dio.options.headers.addAll(NetworkBase.instance.customApiHeader);
      }
    } else {
      headers.forEach((key, value) => dio.options.headers[key] = value);
    }
  }

  Future<dynamic> get({Map<String, dynamic>? params}) async =>
      await _callApi(ApiMethod.get, body: params ?? {});

  Future<dynamic> post(dynamic body) async =>
      await _callApi(ApiMethod.post, body: body);

  Future<dynamic> put(dynamic body) async =>
      await _callApi(ApiMethod.put, body: body);

  Future<dynamic> delete(dynamic body) async =>
      await _callApi(ApiMethod.delete, body: body);

  Future<dynamic> _callApi(ApiMethod method,
      {dynamic body, Map<String, dynamic>? params}) async {
    Response response;
    String encodedUrl = url;
    if (method == ApiMethod.get &&
        !isNullOrEmpty(body) &&
        body is Map<String, dynamic>) {
      encodedUrl = getUrlWithQuery(url, query: body);
    }
    try {
      switch (method) {
        case ApiMethod.get:
          response = await dio.get(encodedUrl);
          break;
        case ApiMethod.post:
          response = await dio.post(encodedUrl, data: body);
          break;
        case ApiMethod.put:
          response = await dio.put(encodedUrl, data: body);
          break;
        case ApiMethod.delete:
          response = await dio.delete(encodedUrl, data: body);
          break;
        case ApiMethod.upload:
          response =
              await dio.post(encodedUrl, data: body, queryParameters: params);
          break;
      }
      if (!isSuccess(response)) {
        throw ApiException(
            response.data?.errorMessage ?? '', response.statusCode ?? 0);
      }
      if (isNullOrEmpty(response.data)) {
        throw ApiException(S.current.no_data, EXCEPTION_CLIENT_UNKNOWN);
      }
    } on DioError catch (de) {
      final statusCode = de.response?.statusCode;
      if (statusCode != null && statusCode == EXCEPTION_SERVER_OVERLOAD) {
        Logger.e('ApiClient -> callApi() on DioError start retry', '$url\n$de');
        await Future.delayed(const Duration(seconds: 2));
        return await _callApi(method, body: body);
      }
      Logger.e('ApiClient -> callApi() on DioError trying...', '$url\n$de');
      switch (de.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw ApiException(S.current.error_timeout, EXCEPTION_CLIENT_TIMEOUT);
        default:
          throw ApiException(S.current.error_no_internet,
              de.response?.statusCode ?? EXCEPTION_CLIENT_SOCKET);
      }
    } catch (e) {
      Logger.e('ApiClient -> callApi()', '$url\n$e');
      throw ApiException(S.current.unknown_error, EXCEPTION_CLIENT_UNKNOWN);
    }
    BaseResponse baseResponse;
    try {
      baseResponse = BaseResponse.fromJson(response.data);
    } catch (e) {
      Logger.e('ApiClient -> callApi() -> parse response', '$e');
      throw ApiException(S.current.unknown_error, EXCEPTION_CLIENT_UNKNOWN);
    }
    if (baseResponse.result != 0) {
      throw ApiException(
          (isNullOrEmpty(baseResponse.friendlyMessage)
                  ? (isNullOrEmpty(baseResponse.errorMessage)
                      ? S.current.unknown_error
                      : baseResponse.errorMessage)
                  : baseResponse.friendlyMessage) ??
              S.current.unknown_error,
          baseResponse.result ?? -1);
    }
    return baseResponse.data;
  }

  Future downloadFile(String savePath) async {
    try {
      await dio.download(url, savePath);
    } catch (e) {
      Logger.e('ApiClient -> downloadFile($url) to $savePath', '$e');
    }
  }

  Future uploadFile(
    String filePath, {
    String? fileName,
    Map<String, dynamic>? params,
  }) async {
    dio.options.contentType = 'multipart/form-data';
    final file = File(filePath);
    if (!(await file.exists())) {
      Logger.e(
        'api_client.dart => uploadFile()',
        'File not found: ${file.path}',
      );
      throw Exception('file_not_found');
    }
    if (isNullOrEmpty(fileName)) fileName = basename(file.path);
    String? mime = lookupMimeType(filePath);
    if (fileName!.endsWith('.db')) {
      mime = 'application/x-sqlite3';
    }
    if (isNullOrEmpty(mime)) {
      mime = 'application/zip';
    }
    final mimeTypeData = mime?.split('/');

    final multiPartFile = await MultipartFile.fromFile(filePath,
        filename: fileName,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
    final form = FormData.fromMap({'image': multiPartFile});
    Logger.i(
      'Upload file info:\n- Length: ${multiPartFile.length}\n- Filename: ${multiPartFile.filename}\n- ContentType: ${multiPartFile.contentType}',
    );
    return await _callApi(ApiMethod.upload, body: form, params: params);
  }

  static bool isSuccess(Response response) =>
      response.statusCode != null &&
      response.statusCode! >= 200 &&
      response.statusCode! < 399;
}
