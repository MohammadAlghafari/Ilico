import 'dart:io';

const headerAuth = HttpHeaders.authorizationHeader;
const kACCESSTOKEN = 'Token';
const kREFRESHTOKEN = 'RefreshToken';
const kAccessTOKENEXPIRATIONDATE = 'AccessTokenExpirationDate';
const REFRESHTOKENEXPIRATIONDATE = 'RefreshTokenExpirationDate';
const userType = "userType";
const isPay = 'isPay';
const kPageSize = 10;
const limit = 20;
const int page = 1;

/////////////api/////////////////////

const String BASE_URL = 'http://api.dev.illico1.com/api/v1/';
const String kExampleUrl = 'https://servicestest.mtnsyr.com:8443/api/Language';
const String graphQlUrl = 'https://demo.saleor.io/graphql/';
const String pagingUrl = 'https://servicestest.mtnsyr.com:8443/api/Notification'; //todo delete
const String uploadfile_URL = "upload/upload-files"; //todo delete
const String LOGIN_URL = "client/auth/local-login";
const String signUpURL = 'client/auth/signup-local';
const String FORGET_PASSWORD_URL = 'client/auth/forget-password';
const String PROFILR_CUSTOMR_URL = 'client/customer';
const String PROFILE_INFL_URL = 'client/influencer';
const String PROFILE_SP_URL = 'client/service-provider';
const String verfication_URL = "client/auth/verify-user";
const String LogOut_URL = "client/auth/logout";
const String Resend_OTP_URL = "client/auth/resend-confirm-otp";
const String update_influncer_social_media = "client/influencer/social-data";
const String EDIT_PROFILE_CUSTOMER_URL = 'client//customer/profile';
const String EDIT_PROFILE_INFL_URL = 'client/influencer/profile';
const String EDIT_PROFILE_SP_URL = 'client/service-provider/profile';
const String EDIT_COMPANY = 'client/service-provider/company';
const String GOOGLE_LOGIN = 'client/auth/google-login';
const String FACEBOOK_LOGIN = 'client/auth/facebook-login';
const String GOOGLE_SIGNUP = 'client/auth/signup-google';
const String FACEBOOK_SIGNUP = 'client/auth/signup-facebook';
const String GET_CATEGORIES_URL = 'client/category';
const String ASSIGN_CATEGORIES_CUSTOMER = 'client/customer/assign-categories';
const String ADD_PRODUCT = 'client/service-provider/create-product';
const String ADD_SERVICE = 'client/service-provider/create-service';
const String ASSIGN_CATEGOIES_INFLUNCER = 'client/influencer/assign-categories';
const String Get_SERVICE = 'client/service-provider/service-provider-services';
const String Get_PRODUCT = 'client/service-provider/service-provider-products';
const String Get_PACKAEG = 'client/package';
const String ASSIGN_CATEGORY_SERVICE = 'client/service-provider/assign-categories';
const String Verfiy_vode_forget_password = 'client/auth/verify-otp';
const String Change_password = 'client/auth/reset-password';
const String ADD_PAYMENT = 'client/service-provider/choose-subscription';
//const String ADD_EVENT = 'client/service-provider/create-event';

const refreshTokenURL = 'auth/refresh';
//////Shared Preference Constant//////
const String firstTimeOpenApp = "first_time_open_app";
