import 'package:beautips/pages/role/kasir/tes)invoice.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExamplePage()));
              },
              icon: Icon(Icons.safety_check))
        ],
      ),
      body: StreamBuilder(
        stream: _transactionStream,
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

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 14,
                                  child: Image.asset('assets/images/blink.png'),
                                ),
                                const SizedBox(height: 21),
                              ],
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 35,
                              child: Image.asset('assets/images/ceklis.png'),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              children: [
                                const SizedBox(height: 21),
                                SizedBox(
                                  width: 14,
                                  child: Image.asset('assets/images/blink.png'),
                                ),
                              ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
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
                          RincianInvoice(
                            rincian: 'Nama Pembeli :',
                            value: data['namaPembeli'],
                          ),
                          RincianInvoice(
                            rincian: 'Nama Barang :',
                            value: data['namaBarang'],
                          ),
                          RincianInvoice(
                            rincian: 'Harga Satuan :',
                            value: 'Rp. ${data['hargaSatuan']}',
                          ),
                          RincianInvoice(
                            rincian: 'Banyaknya Beli :',
                            value: data['jumlahBarang'].toString(),
                          ),
                          RincianInvoice(
                            rincian: 'Total Belanja :',
                            value: 'Rp. ${data['totalBelanja']}',
                          ),
                          RincianInvoice(
                            rincian: 'Uang Pembeli :',
                            value: 'Rp. ${data['uangPembeli']}',
                          ),
                          RincianInvoice(
                            rincian: 'Uang Kembali :',
                            value: 'Rp. ${data['kembalian']}',
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  )
                ],
              );
              // );
            }).toList(),
          );
        },
      ),
    );
  }
}

class RincianInvoice extends StatelessWidget {
  final String rincian;
  final String value;
  const RincianInvoice({
    Key? key,
    required this.rincian,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            rincian,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: Colors.black45,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.black45,
                    overflow: TextOverflow.ellipsis,
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
