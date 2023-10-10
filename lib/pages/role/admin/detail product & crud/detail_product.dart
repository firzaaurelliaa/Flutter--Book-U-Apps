// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:beautips/pages/role/admin/detail%20product%20&%20crud/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetailPage extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductDetailPage({required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  File? image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _logDeleteProduct(String activity) {
    _firestore.collection('log').add({
      'activity': activity,
      'timestamp': FieldValue.serverTimestamp(),
    });
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
          actions: [
            IconButton(
              onPressed: () {
                widget.product.reference.delete().whenComplete(() {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Barang berhasil dihapus",
                      style: TextStyle(
                        color: appWhite,
                      ),
                    ),
                    backgroundColor: apphijau,
                  ));
                  _logDeleteProduct('Admin menghapus produk');
                });
              },
              icon: Icon(
                Icons.delete,
                color: appBlack,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          // margin: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          height: 275,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: (widget.product['foto'].toString() != 'null')
                              ? Image.network(
                                  widget.product['foto'].toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: apphijau,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Icon(
                                    Icons.shopping_basket_rounded,
                                    color: Colors.white,
                                    size: 120,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product['name'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: appBlack,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProductPage(product: widget.product),
                                ),
                              );
                              if (result == true) {
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 22,
                              color: appBlack,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Rp. ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: apphijau,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.product['price'].toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: apphijau,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.product['desc'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

Future<File?> getImageGallery() async {
  ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }
}
