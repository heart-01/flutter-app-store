import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/components/rounded_button.dart';
import 'package:flutter_store/components/text_input.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  // create GlobalKey for Form
  final _formKeyRegister = GlobalKey<FormState>();

  // creaet controller input field
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "ลงทะเบียน",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKeyRegister,
            child: Column(
              children: [
                textInput(
                  hintText: "First Name",
                  inputController: _firstNameController,
                  textInputType: TextInputType.text,
                  autofocus: false,
                  prefixIcon: const Icon(Icons.person),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกชื่อ";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                textInput(
                  hintText: "Last Name",
                  inputController: _lastNameController,
                  textInputType: TextInputType.text,
                  autofocus: false,
                  prefixIcon: const Icon(Icons.person_2),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกนามสกุล";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
                textInput(
                  hintText: "Confirm Password",
                  inputController: _passwordConfirmController,
                  textInputType: TextInputType.text,
                  autofocus: false,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.key),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่านอีกครั้ง";
                    } else if (value != _passwordController.text) {
                      return "รหัสผ่านไม่ตรงกัน";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  label: "SIGN UP",
                  onPressed: () {
                    // validate data form
                    if (_formKeyRegister.currentState!.validate()) {
                      // save state data form to _formKeySignUp
                      _formKeyRegister.currentState!.save();

                      // show data form in console
                      debugPrint("FirstName: ${_firstNameController.text}");
                      debugPrint("LastName: ${_lastNameController.text}");
                      debugPrint("Email: ${_emailController.text}");
                      debugPrint("Password: ${_passwordController.text}");
                      debugPrint(
                          "Confirm Password: ${_passwordConfirmController.text}");
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("มีบัญชีอยู่แล้ว ? "),
              InkWell(
                onTap: () {
                  //Open Login screen here
                  Navigator.pushReplacementNamed(context, AppRouter.login);
                },
                child: const Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
