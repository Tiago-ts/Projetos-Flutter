import 'package:entrada_dados/EntradaSlide.dart';
import 'package:flutter/material.dart';
//import 'package:entrada_dados/EntradaSwitch.dart';
//import 'package:entrada_dados/EntradaCheckbox.dart';
//import 'package:entrada_dados/EntradaRadioButton.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: EntradaRadioButton(),
      //home: EntradaSwitch(),
      home: EntradaSlider(),
    )
  );
}