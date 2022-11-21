import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:core/core.dart';

@GenerateMocks([
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
