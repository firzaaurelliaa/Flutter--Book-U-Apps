// ignore_for_file: use_key_in_widget_constructors

import 'package:beautips/pages/role/kasir/kasir_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KasirDetailProduct extends StatelessWidget {
  final DocumentSnapshot product;

  const KasirDetailProduct({required this.product});

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
                          width: MediaQuery.of(context).size.width,
                          height: 275,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: (product['foto'].toString() != 'null')
                              ? Image.network(
                                  product['foto'].toString(),
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
                      Text(
                        product['name'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appBlack,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
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
                            product['price'].toString(),
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
                        product['desc'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KasirTransaksi(
                                  namabarang: product['name'],
                                  hargasatuan: product['price'].toString(),
                                  // price: product['price'],
                                ),
                              ),
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Beli",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Poppins',
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
              ],
            ),
          ],
        ));
  }
}
