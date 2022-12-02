import 'package:core/src/helpers/analytics_helper.dart';
import 'package:flutter/cupertino.dart';

extension NavigatorX on BuildContext {
  Future<void> pushNamed(String route, {Object? arguments}) async {
    await AnalyticsHelper.log(
      'onEvent(event: [push to $route], arguments: $arguments)',
    );
    Navigator.pushNamed(this, route, arguments: arguments);
  }
}
