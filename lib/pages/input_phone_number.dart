import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okejek_flutter/controller/login/login_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class InputPhoneNumberPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final GoogleSignInAccount googleUser;
  final String tokenId;
  final _formKey = GlobalKey<FormState>();

  InputPhoneNumberPage({
    required this.googleUser,
    required this.tokenId,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OkejekTheme.primary_color,
        title: Text(
          'Isi data informasi',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 3.5),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.6),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  CircleAvatar(
                    maxRadius: SizeConfig.blockSizeHorizontal * 15,
                    child: googleUser.photoUrl == null
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(googleUser.photoUrl!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Center(
                    child: Text(
                      'Selamat datang, Mohon masukkan nomor telepon anda sebelum melanjutkan',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black54,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  TextFormField(
                    controller: loginController.inputPhoneController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'No.Hp tidak boleh kosong'),
                    ]),
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      labelText: 'No.HP',
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        size: 15,
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Obx(
                    () => loginController.isLoading.value
                        ? Transform.scale(
                            scale: 0.5,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
                              primary: OkejekTheme.primary_color,
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              validate();
                              // Get.offAll(() => BottomNavigation());
                            },
                            child: Text(
                              'Selesai',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                                  ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      loginController.loginGoogleAccount(googleUser, tokenId);
    }
  }
}
