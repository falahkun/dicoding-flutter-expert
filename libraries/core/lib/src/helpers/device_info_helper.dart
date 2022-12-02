import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  DeviceInfoHelper._();

  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> deviceName() async {
    if (Platform.isAndroid) {
      final android = await _android();
      return android.model;
    } else if (Platform.isIOS) {
      final ios = await _ios();
      return ios.utsname.machine ?? '-';
    } else {
      return '';
    }
  }

  static Future<IosDeviceInfo> _ios() async => await _deviceInfoPlugin.iosInfo;

  static Future<AndroidDeviceInfo> _android() async =>
      await _deviceInfoPlugin.androidInfo;
}
