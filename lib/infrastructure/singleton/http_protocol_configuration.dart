class HttpProtocolConfiguration {
  final String baseUrl = "ec2-3-12-129-199.us-east-2.compute.amazonaws.com:8080/api";

  static final HttpProtocolConfiguration _instance = HttpProtocolConfiguration._internal();

  HttpProtocolConfiguration get instance => _instance;


  HttpProtocolConfiguration._internal();



}