import 'package:flutter/material.dart';
import 'package:flutter_application_1/Service/auth.dart';
import 'package:flutter_application_1/pages/login_screen.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_application_1/widgets/button_widget.dart';
import 'package:flutter_application_1/widgets/textField_widget_1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<SignScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  // Email ve şifre ile kullanıcı oluşturma
  Future<User?> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        name: _controllerName.text,
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
    return null;
  }

  //controller kontrol edilir ve gerekli hata döndürülür.

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage',
        style: const TextStyle(color: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/login.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xFF1D152D)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textField_1(
                              icon: Icons.person,
                              labelText: "Name",
                              controller: _controllerName,
                              keyboardtype: TextInputType.name),
                          const SizedBox(
                            height: 22,
                          ),
                          textField_1(
                              icon: Icons.email_outlined,
                              labelText: "E-mail",
                              controller: _controllerEmail,
                              keyboardtype: TextInputType.emailAddress),
                          const SizedBox(
                            height: 22,
                          ),
                          textField_1(
                              icon: Icons.lock_outline,
                              labelText: "Password",
                              controller: _controllerPassword,
                              keyboardtype: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 22,
                          ),
                          textField_1(
                              icon: Icons.lock_outline,
                              labelText: "Confirm Password",
                              controller: _controllerConfirmPassword,
                              keyboardtype: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 22,
                          ),
                          _errorMessage(),
                          const SizedBox(
                            height: 5,
                          ),
                          buttonWidget(
                              buttonName: "REGISTER",
                              clr1: const Color(0xFFC1264D),
                              clr2: Colors.transparent,
                              onPressed: createUserWithEmailAndPassword),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already got an account ?  ",
                                style: style4(),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                                },
                                child: Text(
                                  " Login",
                                  style: style3(),
                                ),
                              )
                            ],
                          )),
                          const SizedBox(height: 50)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
