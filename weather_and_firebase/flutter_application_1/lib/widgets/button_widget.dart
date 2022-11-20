import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';

Widget buttonWidget({
  required String buttonName,
  required Color clr1,
  required Color clr2,
  required VoidCallback onPressed,
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
                           onPressed: onPressed,
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