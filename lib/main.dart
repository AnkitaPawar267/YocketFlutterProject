



import 'dart:convert';
import 'dart:io';


import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Pages/rest_page.dart';
import 'PojoClass/rest_response.dart';





void main() => runApp(

    MaterialApp(
      debugShowCheckedModeBanner: false,

//    title: 'FluterLogindemo',
//    theme: new ThemeData(
//        accentColor: Colors.black,
//        primaryColor: Colors.black,
//        primaryColorDark: Colors.black
//
//    ),
//    home: new SplashPage();


      home: new MyRestApp(),
    ),
);




