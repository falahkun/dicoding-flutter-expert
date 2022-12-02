import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key, this.error, this.stackTrace}) : super(key: key);

  final Object? error;
  final StackTrace? stackTrace;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  void initState() {
    super.initState();
    if (widget.error != null) {
      CrashlyticsHelper.recordError(widget.error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Oops something when error!'),
          TextButton(
            onPressed: () {
              CrashlyticsHelper.crash();
            },
            child: Text('Report Error'),
          ),
        ],
      ),
    );
  }
}
