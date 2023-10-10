// ignore_for_file: unused_local_variable, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable, avoid_print, unnecessary_const
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:beautips/theme.dart';

class AdminEditUser extends StatefulWidget {
  DocumentSnapshot docid;
  AdminEditUser({Key? key, required this.docid}) : super(key: key);

  @override
  State<AdminEditUser> createState() => _AdminEditUserState();
}

class _AdminEditUserState extends State<AdminEditUser> {
  TextEditingController role = TextEditingController();
  TextEditingController email = TextEditingController();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    email = TextEditingController(text: widget.docid.get('email'));
    role = TextEditingController(text: widget.docid.get('role'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppBar(
        backgroundColor: appWhite,
        elevation: 0,
        title: Text(
          'Edit Akun Pengguna',
          style: TextStyle(
            color: appBlack,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appBlack,
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Akun berhasil dihapus",
                    style: TextStyle(
                      color: appWhite,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  backgroundColor: apphijau,
                ));
              });
            },
            // onPressed: () async {
            //   final action = await ProductDialogs.yesCancelDialog(context,
            //       'Delete', 'Are you sure to delete this product?');
            //   if (action == ProductDialogsAction.yes) {
            //     setState(() => tappedYes = true);
            //   } else {
            //     setState(() => tappedYes = false);
            //   }
            // },
            child: Icon(
              Icons.delete,
              color: appBlack,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        cursorColor: apphijau,
                        controller: email,
                        maxLength: 25,
                        decoration: InputDecoration(
                          labelText: 'Email :',
                          labelStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                          suffixIcon: IconButton(
                            onPressed: email.clear,
                            icon: const Icon(Icons.clear),
                            color: apphijau,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: apphijau),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        cursorColor: apphijau,
                        maxLength: 25,
                        controller: role,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Role :',
                          labelStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                          suffixIcon: IconButton(
                            onPressed: role.clear,
                            icon: const Icon(Icons.clear),
                            color: apphijau,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: apphijau),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
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
                          onPressed: () {
                            if (email.text.isNotEmpty && role.text.isNotEmpty) {
                              widget.docid.reference.update({
                                'email': email.text,
                                'role': role.text,
                              }).whenComplete(() {
                                Navigator.pop(
                                  context,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Akun berhasil diperbarui",
                                    style: TextStyle(
                                      color: appWhite,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  backgroundColor: apphijau,
                                ));
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Inputan tidak boleh kosong"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: const Text(
                            'Simpan',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
