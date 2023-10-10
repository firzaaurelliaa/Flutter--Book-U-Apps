// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final kasirController = TextEditingController();

  bool _isLoading = false;
  String _selectedKasir = '';

  void changePassword(BuildContext context, String email, String oldPassword,
      String newPassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: oldPassword);
      await userCredential.user!.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to change password')),
      );
    }
  }

  Future<List<String>> _getKasirList() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final List<String> kasirList = [];
    snapshot.docs.forEach((doc) {
      if (doc.data()['role'] == 'Kasir') {
        kasirList.add(doc.data()['email']);
      }
    });
    return kasirList;
  }

  void _showKasirDialog() async {
    final List<String> kasirList = await _getKasirList();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Kasir'),
          content: DropdownButton(
            hint: const Text('Select Kasir'),
            value: _selectedKasir.isEmpty ? null : _selectedKasir,
            onChanged: (value) {
              setState(() {
                _selectedKasir = value.toString();
              });
            },
            items: kasirList.map((String kasir) {
              return DropdownMenuItem(
                value: kasir,
                child: Text(kasir),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                kasirController.text = _selectedKasir;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: kasirController,
                  readOnly: true,
                  onTap: _showKasirDialog,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select a kasir';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Kasir',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: oldPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter old password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Old Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter new password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                onPressed: _isLoading
    ? null
    : () {
      if (formKey.currentState!.validate()) {
        changePassword(
          context,
          kasirController.text.trim(),
          oldPasswordController.text.trim(),
          newPasswordController.text.trim(),
        );
      }
    },
  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ));
  }
}
