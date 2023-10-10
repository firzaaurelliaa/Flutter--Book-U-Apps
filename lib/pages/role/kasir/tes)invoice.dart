import 'package:beautips/pages/role/kasir/kasir_invoice.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _transactionStream =
      FirebaseFirestore.instance
          .collection('transaction')
          .orderBy('timestamp',
              descending: true) // Urutkan berdasarkan waktu terbaru
          .limit(1) // Batasi hanya 1 dokumen
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apphijau,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: apphijau,
        centerTitle: true,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: _transactionStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              return Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 14,
                                child: Image.asset(
                                    'assets/images/blink.png'),
                              ),
                              const SizedBox(height: 21),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 35,
                                child:
                                    Image.asset('assets/images/ceklis.png'),
                              ),
                              const SizedBox(width: 5),
                              const SizedBox(height: 21),
                              SizedBox(
                                width: 14,
                                child: Image.asset(
                                    'assets/images/blink.png'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Transaksi Berhasil!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: appWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Rp. ${data['totalBelanja']}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 35,
                              color: appWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: Image.asset(
                                            'assets/images/money.png'),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        ' Uang kembali :',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          color: appWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Rp. ${data['kembalian']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: appWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    );
                    // );
                  }).toList(),
                ),
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: appWhite,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rincian Pembelian',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: appBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                const RincianInvoice(
                  rincian: 'Nama Pembeli :',
                  value: '',
                ),
                const RincianInvoice(
                  rincian: 'Nama Barang :',
                  value: '',
                ),
                const RincianInvoice(
                  rincian: 'Harga Satuan :',
                  value: '',
                ),
                const RincianInvoice(
                  rincian: 'Banyaknya Beli :',
                  value: '',
                ),
                const RincianInvoice(
                  rincian: 'Total Belanja :',
                  value: '',
                ),
                const RincianInvoice(
                  rincian: 'Uang Pembeli :',
                  value: '',
                ),
                const RincianInvoice(
                  rincian: 'Uang Kembali :',
                  value: '',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
