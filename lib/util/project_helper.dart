import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';

class ConfigHelper {
  static String? deviceId;

  static loadDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      final info = await deviceInfo.webBrowserInfo;
      deviceId = Uri.encodeComponent((info.vendor ?? '') +
          (info.userAgent ?? '') +
          (info.hardwareConcurrency?.toString() ?? ''));
    } else if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      deviceId = Uri.encodeComponent(info.androidId ?? '');
    } else if (Platform.isIOS) {
      final info = await DeviceInfoPlugin().iosInfo;
      deviceId = Uri.encodeComponent(info.identifierForVendor ?? '');
    }
    NetworkBase.instance.addApiHeaders({'deviceId': ConfigHelper.deviceId});
  }
}
