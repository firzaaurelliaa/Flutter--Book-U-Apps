// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api, prefer_final_fields

import 'package:beautips/pages/role/admin/admin_navbottom.dart';
import 'package:beautips/pages/role/kasir/kasir_navbottom.dart';
import 'package:beautips/pages/role/owner/owner_navbottom.dart';
import 'package:beautips/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _isObscure3 = true;
  String _email = '';
  String _password = '';
  String _errorMessage = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  void _logActivity(String activity) {
    _firestore.collection('log').add({
      'activity': activity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: apphijau,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: apphijau,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/images/awan.png'),
                    ),
                  ],
                ),
                Text(
                  'Selamat Datang,',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: appWhite,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Silahkan login terlebih dahulu',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: appWhite,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: appWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 75,
                          height: 75,
                          child: Image.asset('assets/icons/book.png'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'BOOK-U',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: appBlack,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Lorem ipsum dot amet',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: appDarkGray,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            hintText: 'Email :',
                            hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appWhite),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            hintText: 'Kata sandi :',
                            hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appWhite),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            suffixIcon: IconButton(
                              color: appDarkGray,
                              icon: Icon(_isObscure3
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure3 = !_isObscure3;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kata sandi tidak boleh kosong';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _password = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: _email,
                                              password: _password);
                                  User? user = userCredential.user;

                                  if (user != null) {
                                    DocumentSnapshot documentSnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .get();
                                    Map<String, dynamic> data = documentSnapshot
                                        .data() as Map<String, dynamic>;
                                    String role = data['role'];
                                    if (role == 'Admin') {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const NavBottomAdmin(),
                                        ),
                                        (route) => false,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Selamat bekerja, admin',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: appWhite,
                                            ),
                                          ),
                                          backgroundColor: apphijau,
                                        ),
                                      );
                                    } else if (role == 'Kasir') {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NavBottomKasir()),
                                          (route) => false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Selamat bekerja, kasir',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: appWhite,
                                            ),
                                          ),
                                          backgroundColor: apphijau,
                                        ),
                                      );
                                    } else if (role == 'Owner') {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NavBottomOwner()),
                                          (route) => false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Selamat bekerja, owner',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: appWhite,
                                            ),
                                          ),
                                          backgroundColor: apphijau,
                                        ),
                                      );
                                    }
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Pengguna tidak ditemukan",
                                            style: TextStyle(color: appBlack),
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                      );
                                    });
                                  } else if (e.code == 'wrong-password') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Maaf kata sandi salah",
                                            style: TextStyle(color: appBlack),
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                      );
                                    });
                                  }
                                }
                                _logActivity('Masuk -> $_email ');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(350, 38),
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                              primary: apphijau,
                              elevation: 0,
                              shape: const StadiumBorder(),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: appWhite,
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: appWhite,
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
