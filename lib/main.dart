// ignore_for_file: unnecessary_const, depend_on_referenced_packages
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:beautips/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      // initialRoute: '/admin',
      // routes: {
      //   '/admin': (context) => NavBottomAdmin(),
      //   '/kasir': (context) => NavBottomKasir(),
      //   '/owner': (context) => NavBottomOwner(),
      // },
    );
  }
}
