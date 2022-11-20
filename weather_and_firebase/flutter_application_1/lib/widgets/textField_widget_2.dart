 import 'package:flutter/material.dart';

Widget textField_2(
      {required TextInputType keyboardtype,
      //required Widget widget,
      //-context,    
      required String labelText,
      required TextEditingController controller}) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Expanded(
          flex: 8,
          child: TextField(
            readOnly: true,
            controller: controller,
            obscureText: false,
            keyboardType: keyboardtype,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                labelText: labelText,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ],
    );
  }