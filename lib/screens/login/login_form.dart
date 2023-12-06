import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/components/rounded_button.dart';
import 'package:flutter_store/components/social_media_options.dart';
import 'package:flutter_store/components/text_input.dart';
import 'package:flutter_store/services/rest_api.dart';
import 'package:flutter_store/utils/utility.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  // create GlobalKey for Form
  final _formKeyLogin = GlobalKey<FormState>();

  // creaet controller input field email and password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "เข้าสู่ระบบ",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                textInput(
                  hintText: "Email",
                  inputController: _emailController,
                  textInputType: TextInputType.emailAddress,
                  autofocus: false,
                  prefixIcon: const Icon(Icons.email),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกอีเมล";
                    } else if (!value.contains("@")) {
                      return "กรุณากรอกอีเมลให้ถูกต้อง";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                textInput(
                  hintText: "Password",
                  inputController: _passwordController,
                  textInputType: TextInputType.text,
                  autofocus: false,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่าน";
                    } else if (value.length < 6) {
                      return "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        //Open Forgot password screen here
                        Navigator.pushNamed(context, AppRouter.forgotPassword);
                      },
                      child: const Text("ลืมรหัสผ่าน ?"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  label: "LOGIN",
                  onPressed: () async {
                    // validate data form
                    if (_formKeyLogin.currentState!.validate()) {
                      // save state data form to _formKeyLogin
                      _formKeyLogin.currentState!.save();

                      // show data form in console
                      // debugPrint("Email: ${_emailController.text}");
                      // debugPrint("Password: ${_passwordController.text}");

                      var response = await CallAPI().loginAPI({
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      });

                      var body = jsonDecode(response);

                      Utility().logger.i(body);

                      // check context.mounted because it's in an async function.
                      if (context.mounted) {
                        if (body['message'] == 'No Network Connection') {
                          Utility.showAlertDialog(
                            context,
                            'error',
                            body['message'],
                          );
                        } else {
                          if (body['status'] == 'ok') {
                            Utility.showAlertDialog(
                              context,
                              'success',
                              'Login Success.',
                            );
                          } else {
                            _formKeyLogin.currentState!.reset();
                            Utility.showAlertDialog(
                              context,
                              'error',
                              body['message'],
                            );
                          }
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SocialMediaOptions(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ยังไม่มีบัญชีกับเรา ? "),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRouter.register);
                },
                child: const Text(
                  "สมัครฟรี",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
