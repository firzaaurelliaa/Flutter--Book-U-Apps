// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors_in_immutables, avoid_print, deprecated_member_use


import 'dart:typed_data';

import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  final String id;

  AddProduct({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController namaProduct = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController hargaProduct = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool visible = false;
  Uint8List? imageBytes;
  String _category = 'Buku Novel';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _logAddProduct(String activity) {
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
      return bytes;
    }
    return null;
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
        title: Text(
          "Tambah Barang",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: appBlack,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
                onTap: () async {
                  final bytes = await getImageGallery();
                  if (bytes != null) {
                    setState(() {
                      imageBytes = bytes;
                    });
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: imageBytes != null
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.memory(
                            imageBytes!,
                            fit: BoxFit.cover,
                          ),
                        )
                      // ignore: prefer_const_constructors
                      : Icon(
                          Icons.add,
                          color: Colors.black45,
                          size: 40,
                        ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: namaProduct,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang :',
                    labelStyle: const TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: namaProduct.clear,
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
              const SizedBox(height: 25),
              TextFormField(
                controller: deskripsi,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Deskripsi :',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: deskripsi.clear,
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
                      controller: hargaProduct,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Harga :',
                        labelStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: hargaProduct.clear,
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
              Text(
                'Kategori Barang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: apphijau,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _category,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 15),
                underline: Container(
                  height: 2,
                  color: apphijau,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                items: <String>[
                  'Buku Novel',
                  'Buku Pelajaran',
                  'Buku Cerita',
                  'Pulpen',
                  'Penghapus',
                  'Penggaris',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if (namaProduct.text.isNotEmpty &&
                        deskripsi.text.isNotEmpty &&
                        hargaProduct.text.isNotEmpty) {
                      await addProduct();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Barang berhasil ditambahkan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: appWhite,
                            ),
                          ),
                          backgroundColor: apphijau,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Inputan tidak boleh kosong',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: appWhite,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        visible = true;
      });
      try {
        final String imageName =
            'product-image-${DateTime.now().millisecondsSinceEpoch}.jpg';
        final Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('product_images/$imageName');
        final UploadTask uploadTask = firebaseStorageRef.putData(imageBytes!);
        final TaskSnapshot taskSnapshot = await uploadTask;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        final Map<String, dynamic> productData = {
          'name': namaProduct.text,
          'desc': deskripsi.text,
          'price': hargaProduct.text,
          'category': _category,
          'foto': downloadUrl,
          'createdAt': Timestamp.now(),
        };
        await FirebaseFirestore.instance.collection('product').add(productData);
        setState(() {
          visible = false;
        });
        Navigator.pop(context);
        _logAddProduct('Admin menambahkan produk');
      } catch (error) {
        setState(() {
          visible = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal untuk menambahkan barang: $error',
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}


