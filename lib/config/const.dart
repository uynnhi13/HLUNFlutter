import 'dart:ui';

import 'package:flutter/material.dart';

const String urlLogo = "assets/images/hlphone_logo.png";
const Color colorTitle = Color.fromARGB(255, 2, 71, 128);
const Color colorPrimary = Color.fromARGB(255, 18, 111, 187);

TextStyle textTitle(double size) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: colorTitle,
    fontSize: size,
  );
}

//Khung nhập dữ liệu input
TextFormField textInput(String label, TextEditingController Tcontroller) {
  return TextFormField(
    controller: Tcontroller,
    decoration: InputDecoration(
        label: Text(label,style: textTitle(20),),
        hintText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        floatingLabelStyle: const TextStyle(
          color: colorTitle,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: colorTitle,
          ),
          borderRadius: BorderRadius.circular(15),
        )),
  );
}
