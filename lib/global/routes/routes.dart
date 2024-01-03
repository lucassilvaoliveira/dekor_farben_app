class Routes {
  static const String _baseURL = "http://192.168.1.14:8080/api/";
  static const String authenticate =  "${_baseURL}auth/login";
  static const String users = "${_baseURL}users";
  static const String companies = "${_baseURL}companies";
  static const String getCompanyAsset = "$companies/asset/";
}