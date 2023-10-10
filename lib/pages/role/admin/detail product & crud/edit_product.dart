// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, unused_element

import 'dart:typed_data';

import 'package:beautips/pages/role/admin/detail%20product%20&%20crud/detail_product.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends StatefulWidget {
  final DocumentSnapshot product;

  const EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  bool _isLoading = false;
  bool visible = false;
  Uint8List? imageBytes;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _logEditProduct(String activity) {
    _firestore.collection('log').add({
      'activity': activity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<Uint8List?> getImageGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        imageBytes = bytes;
      });
      return bytes;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product['name'];
    _priceController.text = widget.product['price'].toString();
    _descController.text = widget.product['desc'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await widget.product.reference.update({
          'name': _nameController.text,
          'price': int.parse(_priceController.text),
          'desc': _descController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Barang berhasil diperbarui",
              style: TextStyle(color: appWhite),
            ),
            backgroundColor: apphijau,
          ),
        );
        Navigator.pop(context);
        _logEditProduct('Admin memperbarui produk');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Terjadi kesalahan, silahkan coba lagi",
              style: TextStyle(color: appWhite),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> updateProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        visible = true;
      });
      try {
        if (imageBytes == null) {
          await widget.product.reference.update({
            'name': _nameController.text,
            'desc': _descController.text,
            'price': _priceController.text,
            'createdAt': Timestamp.now(),
          });
        } else {
          final String imageName =
              'product-image-${DateTime.now().millisecondsSinceEpoch}.jpg';
          final Reference firebaseStorageRef =
              FirebaseStorage.instance.ref().child('productImages/$imageName');
          await firebaseStorageRef.putData(
              imageBytes!, SettableMetadata(contentType: 'image/jpeg'));
          final imageUrl = await firebaseStorageRef.getDownloadURL();
          await widget.product.reference.update({
            'name': _nameController.text,
            'desc': _descController.text,
            'price': _priceController.text,
            'foto': imageUrl,
            'createdAt': Timestamp.now(),
          });
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // ignore: prefer_const_constructors
            content: Text(
              'Barang berhasil diperbarui',
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            backgroundColor: apphijau,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Terjadi kesalahan, silahkan coba lagi",
              style: TextStyle(color: appWhite),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          visible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppBar(
        backgroundColor: appWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appBlack,
          ),
        ),
        title: const Text(
          'Edit Barang',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  child: imageBytes != null
                      ? Image.memory(imageBytes!, fit: BoxFit.cover)
                      : widget.product['foto'] != null
                          ? Image.network(widget.product['foto'],
                              fit: BoxFit.cover)
                          : const Icon(Icons.image),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Barang tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        labelText: 'Nama Barang :',
                        labelStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                        suffixIcon: IconButton(
                          onPressed: _nameController.clear,
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
                    const SizedBox(height: 25),
                    TextFormField(
                      maxLength: null,
                      maxLines: null,
                      controller: _descController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Deskripsi :',
                        labelStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        suffixIcon: IconButton(
                          onPressed: _descController.clear,
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
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Rp.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: apphijau,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Harga tidak boleh kosong';
                              } else if (int.tryParse(value) == null) {
                                return 'Harga harus berupa angka';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Harga :',
                              labelStyle: const TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              suffixIcon: IconButton(
                                onPressed: _priceController.clear,
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      visible ? null : updateProduct();
                    });
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
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: appWhite,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator(color: apphijau)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
