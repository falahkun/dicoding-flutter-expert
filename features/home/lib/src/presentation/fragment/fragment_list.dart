import 'package:flutter/material.dart';

typedef FragmentListBuilder = Widget Function(BuildContext context, dynamic value);

class FragmentList<T> extends StatelessWidget {
  const FragmentList({Key? key, required this.list, required this.builder}) : super(key: key);

  final List<T> list;
  final FragmentListBuilder builder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list.map((data) => builder(context, data)).toList(),
      ),
    );
  }
}
