import 'package:flutter/material.dart';

OutlineInputBorder styleBorder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.blueGrey,
        width: 1.8,
      ),
    );
  }

OutlineInputBorder styleBorderError(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.red,
        width: 1.8,
      ),
    );
  }