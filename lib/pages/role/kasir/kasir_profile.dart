// ignore_for_file: prefer_const_constructors, unused_import, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:beautips/auth/dialog.dart';
import 'package:beautips/auth/login.dart';
import 'package:beautips/pages/role/admin/admin_edit_user.dart';
import 'package:beautips/pages/role/admin/admin_profile.dart';
import 'package:beautips/theme.dart';
import 'package:beautips/widget/profile_fitur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class KasirProfile extends StatefulWidget {
  const KasirProfile({Key? key}) : super(key: key);

  @override
  State<KasirProfile> createState() => _KasirProfileState();
}

class _KasirProfileState extends State<KasirProfile> {
  bool tappedYes = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Stream<DocumentSnapshot> _profileStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

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
        backgroundColor: apphijau,
        elevation: 0,
      ),
      backgroundColor: appWhite,
      body: StreamBuilder(
        stream: _profileStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Tunggu sebentar, ada yang salah:(");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: apphijau,
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.37,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    color: apphijau,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                color: appWhite,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(25),
                                child: Image.asset('assets/icons/kerja.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        snapshot.data!['role'],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: appWhite,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '- ' + snapshot.data!['email'] + ' -',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          color: appWhite,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.03,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 1.7,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: 15),
                            ProfilFitur(
                              data: 'Email',
                              isi: snapshot.data!['email'],
                            ),
                            ProfilFitur(
                              data: 'Role',
                              isi: snapshot.data!['role'],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
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
                    onPressed: () async {
                      final action = await AlertDialogs.yesCancelDialog(
                          context, 'Keluar', 'Yakin untuk keluar akun?');
                      if (action == DialogsAction.yes) {
                        setState(() => tappedYes = true);
                      } else {
                        setState(() => tappedYes = false);
                      }
                      _logActivity('Keluar -> ' + snapshot.data!['email']);
                    },
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

enum DialogsAction { yes, cancel }

Future<void> logout(BuildContext context) async {
  const CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false);
}
