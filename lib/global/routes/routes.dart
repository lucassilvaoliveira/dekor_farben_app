class Routes {
  static const String _baseURL = "http://172.20.128.1:8080/api/";
  static const String authenticate =  "${_baseURL}auth/login";
  static const String users = "${_baseURL}users";
  static const String companies = "${_baseURL}companies";
  static const String campaigns = "${_baseURL}campaigns";
  static const String recentWorks = "${_baseURL}recent-works";
  static const String getCompanyAsset = "$companies/asset/";
  static const String getCampaignsByCompanyId = "$campaigns/company";
  static const String getRecentWorkAsset = "$recentWorks/asset/";
}