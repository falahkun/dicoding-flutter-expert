import 'package:core/src/helpers/device_info_helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsHelper {
  CrashlyticsHelper._();

  static FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  static void recordError([Object? error, StackTrace? stackTrace]) async {
    final device = await DeviceInfoHelper.deviceName();
    _crashlytics
        .log('onError(device: $device, err: $error, stackTrace: $stackTrace)');
  }

  static void crash() => _crashlytics.crash();
}
