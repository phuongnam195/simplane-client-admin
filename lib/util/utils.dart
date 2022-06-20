import 'package:intl/intl.dart';

import 'logger.dart';

bool isNullOrEmpty(dynamic s) {
  if (s != null && s is String) {
    s = s.trim();
  }
  try {
    return s == null || s.isEmpty;
  } catch (_) {
    return s == null;
  }
}

List<String> splitByLength(String value, int length) {
  final logList = <String>[];
  if (value.length <= length) {
    logList.add(value);
  } else {
    final size = (value.length / length).ceil();
    int startIndex = 0;
    int endIndex = startIndex + length;
    for (int i = 0; i < size; i++) {
      logList.add(value.substring(startIndex, endIndex));
      startIndex = endIndex;
      endIndex = startIndex + length;
      if (endIndex > value.length) endIndex = value.length;
    }
  }
  return logList;
}

String getUrlWithQuery(String url, {Map<String, dynamic>? query}) {
  var result = StringBuffer();
  if (query != null && query.isNotEmpty) {
    result.write(url);
    result.write('?');
    for (int i = 0; i < query.length; i++) {
      if (i != 0) result.write('&');
      result.write(query.keys.elementAt(i));
      result.write('=');
      result.write(Uri.encodeComponent('${query.values.elementAt(i)}'));
    }
    return result.toString();
  } else {
    return url;
  }
}

String formatCurrency(dynamic price) {
  try {
    return NumberFormat("#,##0", "en_US").format(price) + ' đ';
  } catch (e) {
    Logger.e('utils.dart -> formatCurrency($price)', '$e');
    return '0';
  }
}

String formatCurrencyPdf(dynamic price) {
  try {
    return NumberFormat("#,##0", "en_US").format(price) + ' VND';
  } catch (e) {
    Logger.e('utils.dart -> formatCurrency($price)', '$e');
    return '0';
  }
}
