class Routes {
  static const String _baseURL = "http://192.168.1.10:8080/api/";
  static const String authenticate =  "${_baseURL}auth/login";
  static const String users = "${_baseURL}users";
  static const String companies = "${_baseURL}companies";
  static const String campaigns = "${_baseURL}campaigns";
  static const String recentWorks = "${_baseURL}recent-works";
  static const String products = "${_baseURL}products";
  static const String invoices = "${_baseURL}invoices";
  static const String getCompanyAsset = "$companies/asset/";
  static const String getCampaignsByCompanyId = "$campaigns/company";
  static const String getRecentWorkAsset = "$recentWorks/asset/";
  static const String getProductAsset = "$products/asset/";
  static const String invoiceAsset = "$invoices/asset/";
}