import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/api/user_controller.dart';
import 'package:okejek_flutter/controller/auth/profile/profile_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class EditProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    UserController userController = Get.find();
    ProfileController profileController = Get.find();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
        title: Text(
          'Edit Profil',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TF nama
                Obx(
                  () => Padding(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    child: TextFormField(
                      initialValue: userController.name.value,
                      onSaved: (newValue) {
                        profileController.name.value = newValue!;
                      },
                      validator: RequiredValidator(errorText: 'Name cannot be empty'),
                      style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                          color: Colors.black54,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: SizeConfig.safeBlockHorizontal * 3,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                ),

                // TF Email
                Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                  child: TextFormField(
                    initialValue: userController.email.value,
                    onSaved: (newValue) {
                      profileController.email.value = newValue!;
                    },
                    // validator: RequiredValidator(errorText: 'Email cannot be empty'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email cannot be empty'),
                      EmailValidator(errorText: 'Wrong Email Format')
                    ]),
                    style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                        color: Colors.black54,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                ),

                // TF passwrod
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (newValue) {
                          profileController.password.value = newValue!;
                        },
                        // validator: RequiredValidator(errorText: 'Password cannot be empty'),
                        style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.vpn_key_outlined,
                            size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                            color: Colors.black54,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: SizeConfig.safeBlockHorizontal * 3,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 15 / 3.6),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '* ',
                              style: TextStyle(color: Colors.red[300]),
                            ),
                            TextSpan(
                              text: 'Leave blank to keep the old password',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),

                // TF phone
                Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialValue: userController.contactMobile.value,
                    onSaved: (newValue) {
                      profileController.contactPhone.value = newValue!;
                      // profileController.changeValueController(profileController.contactPhone, newValue!);
                    },
                    validator: RequiredValidator(errorText: 'Phone Number cannot be empty'),
                    style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                        color: Colors.black54,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                ),

                Obx(
                  () => profileController.isLoading.value
                      ? Center(
                          child: Container(
                            height: SizeConfig.safeBlockVertical * 10 / 7.2,
                            width: SizeConfig.safeBlockHorizontal * 10 / 7.2,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                  'Profile Saved!',
                                  style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                  ),
                                )),
                              );
                              profileController.editProfil();
                              Get.back();
                            }
                          },
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
