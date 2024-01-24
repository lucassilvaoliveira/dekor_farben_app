class HttpProtocolConfiguration {
  final String baseUrl = "https://decor-coins.onrender.com/api";

  static final HttpProtocolConfiguration _instance = HttpProtocolConfiguration._internal();

  HttpProtocolConfiguration get instance => _instance;


  HttpProtocolConfiguration._internal();



}