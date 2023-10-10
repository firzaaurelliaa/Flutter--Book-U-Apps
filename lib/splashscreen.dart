// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'package:beautips/auth/login.dart';
import 'package:beautips/pages/role/admin/admin_navbottom.dart';
import 'package:beautips/pages/role/kasir/kasir_navbottom.dart';
import 'package:beautips/pages/role/owner/owner_navbottom.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String _userRole = "";

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // ambil data user dari Firebase
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        _userRole = userData.data()!['role'];

        // cek role user dan arahkan ke halaman yang sesuai
        if (_userRole == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavBottomAdmin()),
          );
          
        } else if (_userRole == 'Kasir') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavBottomKasir()),
          );
        } else if (_userRole == 'Owner') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavBottomOwner()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                    const SplashIcon(icon: 'assets/icons/buku.png'),
                    const SplashIcon(icon: 'assets/icons/read.png'),
                    const SplashIcon(icon: 'assets/icons/open_book.png'),
                    const SplashIcon(icon: 'assets/icons/book1.png'),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              'BOOK-U',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: apphijau,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashIcon extends StatelessWidget {
  final String icon;

  const SplashIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Opacity(opacity: 0.2, child: Image.asset(icon)),
    );
  }
}
