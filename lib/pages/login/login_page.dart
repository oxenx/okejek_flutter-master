import 'package:entry/entry.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/login/login_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/register_page.dart';
import 'package:okejek_flutter/widgets/loading_animation.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoginController loginController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OkejekTheme.primary_color,
        elevation: 0.0,
        title: Text(
          'Masuk',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.6),
                child: Entry.opacity(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 500),
                  opacity: 0.5,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      tfEmail(loginController),
                      tfPassword(loginController),
                      Obx(
                        () => loginController.isLoading.value
                            ? LoadingAnimation()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                                    child: Text(
                                      'Lupa password?',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: OkejekTheme.primary_color,
                                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2.7),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        validating(loginController);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: OkejekTheme.primary_color,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(OkejekTheme.button_rounded_corner),
                                        ),
                                      ),
                                      child: Container(
                                        height: 40,
                                        child: Center(
                                          child: Text(
                                            'Masuk',
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Belum punya akun?'.tr,
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                color: OkejekTheme.primary_color,
                                                fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                                          ),
                                          TextSpan(
                                            text: ' Daftar Gratis',
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                color: OkejekTheme.primary_color,
                                                fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                                fontWeight: FontWeight.w600),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.off(() => RegisterPage(), transition: Transition.fadeIn);
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.1,
                                  ),
                                ],
                              ),
                      ),
                      Obx(() => loginController.isLoginFailure.value
                          ? Padding(
                              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.5),
                              child: Text(
                                'Email atau Password salah. Silahkan coba lagi',
                                style: TextStyle(color: Colors.orange, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tfEmail(LoginController loginController) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: TextFormField(
        controller: loginController.emailController,
        validator: MultiValidator([
          EmailValidator(errorText: 'Format email salah'),
          RequiredValidator(errorText: 'Email tidak boleh kosong')
        ]),
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
        style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
        decoration: InputDecoration(
          labelText: 'Alamat Email',
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.black54,
          ),
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: SizeConfig.safeBlockHorizontal * 3,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget tfPassword(LoginController loginController) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: TextFormField(
        obscureText: true,
        controller: loginController.passwordController,
        validator: RequiredValidator(errorText: 'Password tidak boleh kosong'),
        style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(
            Icons.vpn_key_outlined,
            color: Colors.black54,
          ),
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: SizeConfig.safeBlockHorizontal * 3,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void validating(LoginController loginController) {
    loginController.emailController.text.replaceAll(' ', '');
    loginController.passwordController.text.replaceAll(' ', '');

    if (_formKey.currentState!.validate()) {
      loginController.loginViaEmail(loginController.emailController.text, loginController.passwordController.text);
    }
  }
}
