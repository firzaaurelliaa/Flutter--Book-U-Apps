// ignore_for_file: library_private_types_in_public_api, unused_local_variable, prefer_is_empty

import 'package:beautips/pages/role/admin/detail%20product%20&%20crud/detail_product.dart';
import 'package:beautips/pages/role/kasir/kasir_detail_product.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KasirPenghapus extends StatefulWidget {
  const KasirPenghapus({Key? key}) : super(key: key);

  @override
  _KasirPenghapusState createState() => _KasirPenghapusState();
}

class _KasirPenghapusState extends State<KasirPenghapus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penghapus',
          style: TextStyle(
            color: appBlack,
            fontFamily: 'Poppins',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product')
            .where('category', isEqualTo: 'Penghapus')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: apphijau,
                  ),
                ),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: appBlack,
                  ),
                )
              ],
            );
          }
          if (snapshot.data?.docs.length == 0) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: appWhite,
              ),
              backgroundColor: appWhite,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 175,
                      height: 175,
                      child: Image.asset('assets/icons/box.png'),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Stok barang sedang kosong :(',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KasirDetailProduct(
                          product: snapshot.data!.docs[index]),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              snapshot.data!.docs[index]['foto'],
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
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.data!.docs[index]['name'],
                            style: TextStyle(
                              color: appBlack,
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            snapshot.data!.docs[index]['desc'].toString(),
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Rp. ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: apphijau,
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]['price'].toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: apphijau,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
