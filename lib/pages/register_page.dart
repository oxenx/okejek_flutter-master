import 'package:entry/entry.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/register/register_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/login/login_page.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: OkejekTheme.primary_color,
        elevation: 0.0,
        title: Text(
          'Daftar akun baru',
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
                  opacity: 0,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      tfUsername(),
                      tfEmail(),
                      tfPassword(),
                      tfPhoneNumber(),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                        child: Obx(
                          () => registerController.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    // Get.offAll(BottomNavigation());
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    validating();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: OkejekTheme.primary_color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(OkejekTheme.button_rounded_corner),
                                    ),
                                  ),
                                  child: Container(
                                    height: SizeConfig.blockSizeVertical * 5,
                                    child: Center(
                                      child: Text(
                                        'Daftar Sekarang',
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sudah punya akun?'.tr,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: OkejekTheme.primary_color, fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                              ),
                              TextSpan(
                                text: ' Silahkan login',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: OkejekTheme.primary_color,
                                    fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.off(() => LoginPage(), transition: Transition.fadeIn);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
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

  Widget tfUsername() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: TextFormField(
        controller: registerController.namaController,
        validator: RequiredValidator(errorText: 'Nama Pengguna tidak boleh kosong'),
        style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
        decoration: InputDecoration(
          labelText: 'Nama Pengguna',
          prefixIcon: Icon(
            Icons.person_outline,
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

  Widget tfEmail() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: TextFormField(
        controller: registerController.emailController,
        style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
        validator: MultiValidator([
          EmailValidator(errorText: 'Format email salah'),
          RequiredValidator(errorText: 'Email tidak boleh kosong')
        ]),
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
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

  Widget tfPassword() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: TextFormField(
        obscureText: true,
        controller: registerController.passwordController,
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

  Widget tfPhoneNumber() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: TextFormField(
        controller: registerController.telphoneController,
        validator: RequiredValidator(errorText: 'No.HP tidak boleh kosong'),
        style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'No.HP',
          prefixIcon: Icon(
            Icons.phone_outlined,
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

  validating() {
    if (_formKey.currentState!.validate()) {
      registerController.register(failureSnackbar);
    }
  }

  failureSnackbar() {
    final snackbar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        'Email atau No.HP sudah terdaftar',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
  }
}
