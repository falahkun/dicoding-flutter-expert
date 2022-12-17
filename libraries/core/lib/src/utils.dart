import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();


Future<SecurityContext> get globalContext async {
  // [success] => themoviedb.pem
  // [failed] => formulae.brew.sh
  final sslCert = await rootBundle.load('assets/certificates/themoviedb.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}