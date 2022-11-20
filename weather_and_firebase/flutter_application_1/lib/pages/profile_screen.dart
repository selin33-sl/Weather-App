import 'package:flutter/material.dart';
import 'package:flutter_application_1/Service/auth.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/styles/styles.dart';

import 'package:flutter_application_1/widgets/textField_widget_2.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  String city;
  // String name;
  // String email;
  // String phone;
  // String password;
  ProfileScreen({
    Key? key,
    required this.city,
    // required this.name,
    // required this.email,required this.phone,required this.password
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _passwordVisible = false;
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut(context, const SplashScreen());
  }

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  final TextEditingController _numbercontroller = TextEditingController();

  @override
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            color: const Color(0xFFF0A989),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xFFF0A989)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circleButton(
                              context: context,
                              icon: Icons.arrow_back_ios_new_sharp,
                              color: Colors.white,
                              iconColor: const Color(0xFFBD301E),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          circleButton(
                              context: context,
                              icon: Icons.logout_outlined,
                              color: Colors.white,
                              iconColor: const Color(0xFFBD301E),
                              onPressed: signOut),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 8,
                  child: Container(
                    //padding: const EdgeInsets.only(left:35,right: 35 ),
                    constraints: const BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover)),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          left: 108,
                          right: 108,
                          top: 30,
                          child: GestureDetector(
                            onTap: () {
                              debugPrint("Butona tıklandı");
                            },
                            child: Container(
                              margin: const EdgeInsets.all(16.0),
                              width: 151,
                              height: 151,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/user.jpg'),
                                      fit: BoxFit.cover),
                                  border: Border.all(
                                    width: 4,
                                    color: const Color(0xFFBD301E),
                                    style: BorderStyle.solid,
                                  ),
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                              child: Stack(clipBehavior: Clip.none, children: [
                                Positioned(
                                    left: 110,
                                    right: 0,
                                    top: 110,
                                    child: circleButton(
                                        icon: Icons.edit,
                                        color: const Color(0xFFBD301E),
                                        iconColor: Colors.white,
                                        onPressed: () {}))
                              ]),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          right: 100,
                          bottom: 50,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'widget.namefdgdgdgdg',
                                    style: style6(),
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  Text(
                                    widget.city,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                      decoration: const BoxDecoration(color: Color(0xFFBC5953)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 20),
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                row(text: "E-mail", icon: Icons.mail),
                                textField_2(
                                    labelText: 'widget.email',
                                    controller: _emailcontroller,
                                    keyboardtype: TextInputType.emailAddress),
                                row(text: "Password", icon: Icons.lock_outline),
                                TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  controller: _passwordcontroller,
                                  obscureText:
                                      !_passwordVisible, //This will obscure text dynamically
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'widget.password',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      )),
                                ),
                                row(text: "Phone number", icon: Icons.phone),
                                textField_2(
                                    labelText: ' widget.phone',
                                    controller: _numbercontroller,
                                    keyboardtype: TextInputType.number),
                              ],
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget circleButton(
      {context,
      required VoidCallback onPressed,
      required IconData icon,
      required Color color,
      required Color iconColor}) {
    return Container(
      child: IconButton(
        color: iconColor,
        onPressed: onPressed,
        icon: Center(child: Icon(icon)),
      ),
      width: 42,
      height: 42,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget row({
    required String text,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon),
        Text(
          text,
          style: style5(),
        )
      ],
    );
  }
}
