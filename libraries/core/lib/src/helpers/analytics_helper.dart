import 'dart:io';

import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  const AnalyticsHelper._();

  static FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> log([String? event, Object? arguments]) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return;
    final deviceName = await DeviceInfoHelper.deviceName();
    await _analytics.logEvent(name: event ?? 'App', parameters: {
      'device': deviceName,
      'arguments': arguments ?? {}
    });
  }
}