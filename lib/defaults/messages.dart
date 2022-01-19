import 'package:get/get.dart';
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'id_ID': {
      'version': "Versi: ",
      'action_login': "Masuk",
      'action_login_with_google': "Masuk dengan Akun Google",
      'action_register': "Daftar",
    },
    'en_US': {
      'version': "Version: ",
      'action_login': "Login",
      'action_login_with_google': "Login with Akun Google",
      'action_register': "Register",
    },
  };
}