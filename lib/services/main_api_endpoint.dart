class ApiEndPoint {
  static const serverUrl = 'api.etonestop.com';
  static const endpoint = 'https://$serverUrl/api';
  static const prodHost = 'https://onestop.com/category?slug=';
  static const authorisationUrl = 'https://auth.appliedline.com/Account/Login';

  // ASSET FILE
  static const appLogo = 'assets/logo.png';
  static const adminLogo = 'assets/user.png';
  static const sidebarLogo = 'assets/logo_.png';
  static const loginPageLogo = 'assets/loginPageLogo.png';

  // NETWORK FILES
  static const getAgentImage = '$endpoint/agents/image';
  static const getCustomerImage = '$endpoint/users/image';

  static const getWitnessImage = '$endpoint/witness/file';
  static const getProviderImage = '$endpoint/taskers/image';
  static const getCompanyImage = '$endpoint/companies/image';
  static const getCategoryImage = '$endpoint/newcategories/image';
  static const getMainCategoryImage = '$endpoint/maincategories/image';
}
