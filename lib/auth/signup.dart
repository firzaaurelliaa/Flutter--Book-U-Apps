// ignore_for_file: sort_child_properties_last, library_private_types_in_public_api, use_build_context_synchronously, prefer_is_empty, unused_local_variable

import 'dart:io';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  _SignupState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  bool _isLoading = false;
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var options = ['Admin', 'Kasir', 'Owner'];
  var _currentItemSelected = "Admin";
  var role = "Admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apphijau,
      appBar: AppBar(
        backgroundColor: apphijau,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: appWhite,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Tambahkan akun jika diperlukan',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: appWhite,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: appWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: emailController,
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
                              if (value!.length == 0) {
                                return "Inputan tidak boleh kosong";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: _isObscure,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: Colors.grey.shade400,
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              enabled: true,
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
                            ),
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Inputan tidak boleh kosong";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Kata sandi minimal 6 karakter");
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: _isObscure2,
                            controller: confirmpassController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: Colors.grey.shade400,
                                  icon: Icon(
                                    _isObscure2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure2 = !_isObscure2;
                                    });
                                  }),
                              enabled: true,
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Konfirmasi Kata Sandi :',
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
                              if (confirmpassController.text !=
                                  passwordController.text) {
                                return "Maaf, password salah";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sebagai : ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: apphijau,
                                    fontFamily: 'Poppins'),
                              ),
                              DropdownButton<String>(
                                dropdownColor: appWhite,
                                isDense: true,
                                isExpanded: false,
                                iconEnabledColor: appWhite,
                                focusColor: appPink,
                                items: options.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(
                                      dropDownStringItem,
                                      style: TextStyle(
                                        color: apphijau,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValueSelected) {
                                  setState(() {
                                    _currentItemSelected = newValueSelected!;
                                    role = newValueSelected;
                                  });
                                },
                                value: _currentItemSelected,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                signUp(emailController.text,
                                    passwordController.text, role);
                              },
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: appWhite,
                                    )
                                  : Text(
                                      'Daftar',
                                      style: TextStyle(
                                        color: appWhite,
                                        fontFamily: 'Poppins',
                                        fontSize: 17,
                                      ),
                                    ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(350, 38),
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                primary: apphijau,
                                elevation: 0,
                                shape: const StadiumBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password, String role) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, role)})
          .catchError((e) {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Berhasil membuat akun",
            style: TextStyle(color: appWhite),
          ),
          backgroundColor: apphijau,
        ),
      );
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'role': role});
    Navigator.pop(context);
  }
}
