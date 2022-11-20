 import 'package:flutter/material.dart';

Widget textField_1(
      {required TextInputType keyboardtype,

     
      required IconData icon,
      required String labelText,
      required TextEditingController controller}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 25.0,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              obscureText: false,
              keyboardType: keyboardtype,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  
                  filled: true,
                  fillColor: Colors.transparent,
                  labelText: labelText,
                  labelStyle: const TextStyle(color: Colors.white),
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
        ),
      ],
    );
  }