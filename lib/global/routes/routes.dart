class Routes {
  static const String _baseURL = "https://decor-coins.onrender.com/api/";
  static const String authenticate =  "${_baseURL}auth/login";
  static const String users = "${_baseURL}users";
  static const String companies = "${_baseURL}companies";
  static const String campaigns = "${_baseURL}campaigns";
  static const String recentWorks = "${_baseURL}recent-works";
  static const String products = "${_baseURL}products";
  static const String invoices = "${_baseURL}invoices";
  static const String invoiceByCompany = "$invoices/find-by-company";
  static const String validateInvoice = "$invoices/validate";
  static const String getCompanyAsset = "$companies/asset/";
  static const String getCampaignsByCompanyId = "$campaigns/company";
  static const String getRecentWorkAsset = "$recentWorks/asset/";
  static const String uploadRecentWorkAsset = "$recentWorks/upload-recent-work-asset";
  static const String getProductAsset = "$products/asset/";
  static const String invoiceAsset = "$invoices/asset/";
}