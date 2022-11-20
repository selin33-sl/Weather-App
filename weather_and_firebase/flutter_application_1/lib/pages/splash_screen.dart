import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_screen.dart';
import 'package:flutter_application_1/pages/sign_screen.dart';
import 'package:flutter_application_1/styles/styles.dart';

class SplashScreen
 extends StatefulWidget {
  const SplashScreen
  ({ Key? key }) : super(key: key);

  @override
  State<SplashScreen
  > createState() => _MainScreenState();
}

class _MainScreenState extends State<SplashScreen
> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/images/login.jpg",fit: BoxFit.cover,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                 buttonWidget(buttonName: "LOGIN",clr1:Colors.transparent,clr2: Colors.white,widget:  LoginScreen(),context: context),
                 const SizedBox(height: 8,),
                 buttonWidget(buttonName: "SIGN UP", clr1: const Color(0xFFC1264D),clr2: Colors.transparent,widget: const SignScreen(),context: context),   
                 const SizedBox(height: 70,)
               



              ],
            ),
          ],
        ),
        ),
      
    );
  }
}

Widget buttonWidget({
  required String buttonName,
  required Color clr1,
  required Color clr2,
  required Widget widget,
  context,
}){
  return  Padding(
                   padding: const EdgeInsets.only(left: 82,right: 82),
                   child: Container(
                         
                         decoration: BoxDecoration(
                           
                             borderRadius: BorderRadius.circular(20),
                             border:  Border(
                               bottom: BorderSide(color: clr2),
                               top: BorderSide(color:clr2),
                               left: BorderSide(color: clr2),
                               right: BorderSide(color: clr2),
                             )),
                         child: MaterialButton(
                           minWidth: double.infinity,
                           height: 60,
                           onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> widget ));
                           },
                           color: clr1,
                           elevation: 10,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child:  Text(
                             buttonName,
                             style: style1()
                           ),
                         ),
                       ),
                 ) ;
}

// ignore: non_constant_identifier_names
