// ignore_for_file: prefer_const_constructors, unused_import, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:beautips/auth/dialog.dart';
import 'package:beautips/auth/ganti_password.dart';
import 'package:beautips/auth/login.dart';
import 'package:beautips/auth/signup.dart';
import 'package:beautips/pages/role/admin/admin_edit_user.dart';
import 'package:beautips/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String title = 'AlertDialog';
  bool tappedYes = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final name = TextEditingController();
  final email = TextEditingController();

  final Stream<QuerySnapshot> _profileStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  void _logActivity(String activity) {
    _firestore.collection('log').add({
      'activity': activity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: apphijau,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => Signup())));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: appBackground,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final action = await AlertDialogs.yesCancelDialog(
                  context, 'Keluar', 'Yakin untuk keluar akun?');
              if (action == DialogsAction.yes) {
                setState(() => tappedYes = true);
                var snapshot;
                _logActivity('Keluar -> ' + snapshot.data!['email']);
              } else {
                setState(() => tappedYes = false);
              }
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
        backgroundColor: apphijau,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo admin!',
                style: TextStyle(
                  fontSize: 21,
                  fontFamily: 'Poppins',
                  color: appWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Silahkan cek akun pengguna Book-U',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade200,
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _profileStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              // print(snapshot.data!.docs[index].id);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: appWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/icons/kerja.png'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['role'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: appBlack,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot.data!.docs[index]['email'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: appBlack,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordPage()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

enum DialogsAction { yes, cancel }

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Future<void> logout(BuildContext context) async {
  const CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false);
}
