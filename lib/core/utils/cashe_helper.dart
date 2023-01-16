import 'package:charja_charity/core/constants/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<void> removeLoginData() async {
    await sharedPreferences.remove(kACCESSTOKEN);
    await sharedPreferences.remove(kREFRESHTOKEN);
    await sharedPreferences.remove(kAccessTOKENEXPIRATIONDATE);
    await sharedPreferences.remove(REFRESHTOKENEXPIRATIONDATE);
    await sharedPreferences.remove(isPay);
    await sharedPreferences.remove(userType);
  }

  static bool get authorized {
    if (sharedPreferences.get(userType) != 'ServiceProvider') {
      return sharedPreferences.get(kACCESSTOKEN) != null;
    } else {
      if (sharedPreferences.get(isPay) != null &&
          sharedPreferences.get(isPay) == true &&
          sharedPreferences.get(kACCESSTOKEN) != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  static String? getRole() {
    String temp = CashHelper.getData(key: userType);
    return temp;
  }
}
