import 'package:shared_preferences/shared_preferences.dart';

class SharedInfo {
  late SharedPreferences sharedPref;

  void sharedLoginInfo(
      int id, String email, String name, String hakAkses) async {
    sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt("id", id);
    sharedPref.setString("email", email);
    sharedPref.setString("name", name);
    sharedPref.setString("hak_akses", hakAkses);
  }
}
