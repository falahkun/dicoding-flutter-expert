import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';

  @override
  Widget build(BuildContext context) {
    String path = 'assets';
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      path = '../../assets';
    }
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
                Expanded(
                  child: Container(
                    color: kPrussianBlue,
                    child: Center(
                      child: Image.asset(
                        '$path/circle-g.png',
                        width: 128,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kMikadoYellow,
                  child: Text(
                    'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
