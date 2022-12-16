import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();


Future<SecurityContext> get globalContext async {
  // assets/certificates/themoviedb.pem
  final sslCert = await rootBundle.load('assets/certificates/formulae.brew.sh.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}