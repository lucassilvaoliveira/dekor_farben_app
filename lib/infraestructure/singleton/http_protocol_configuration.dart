class HttpProtocolConfiguration {
  final String baseUrl = "http://localhost:8080/api";

  static final HttpProtocolConfiguration _instance = HttpProtocolConfiguration._internal();

  HttpProtocolConfiguration get instance => _instance;


  HttpProtocolConfiguration._internal();



}