import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/components/text_input.dart';
import 'package:flutter_store/components/rounded_button.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({super.key});

  // create GlobalKey for Form
  final _formKeyForgotPassword = GlobalKey<FormState>();

  // creaet controller input field email and password
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "ลืมรหัสผ่าน",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              key: _formKeyForgotPassword,
              child: Column(children: [
                textInput(
                    inputController: _emailController,
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    obscureText: false,
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return "กรุณากรอกอีเมล";
                      } else if (!value.contains("@")) {
                        return "กรุณากรอกอีเมลให้ถูกต้อง";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                    label: "RESET PASSWORD",
                    onPressed: () {
                      if (_formKeyForgotPassword.currentState!.validate()) {
                        // save state data form to _formKeyForgotPassword
                        _formKeyForgotPassword.currentState!.save();

                        // show data form in console
                        debugPrint("Email: ${_emailController.text}");
                      }
                    })
              ])),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("มีบัญชีอยู่แล้ว ? "),
              InkWell(
                onTap: () {
                  // go to Login
                  Navigator.pop(context);
                },
                child: const Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ยังไม่มีบัญชีกับเรา ? "),
              InkWell(
                onTap: () {
                  // go to Register
                  Navigator.pushReplacementNamed(context, AppRouter.register);
                },
                child: const Text(
                  "สมัครสมาชิก",
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
