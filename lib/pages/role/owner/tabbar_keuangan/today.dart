// ignore_for_file: library_private_types_in_public_api

import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
}

class KeuanganHariIni extends StatefulWidget {
  const KeuanganHariIni({Key? key}) : super(key: key);

  @override
  _KeuanganHariIniState createState() => _KeuanganHariIniState();
}

class _KeuanganHariIniState extends State<KeuanganHariIni> {
  final Stream<QuerySnapshot> _transactionStream = FirebaseFirestore.instance
      .collection('transaction')
      .where('timestamp',
          isGreaterThanOrEqualTo: DateTime.now().startOfDay(),
          isLessThanOrEqualTo: DateTime.now().endOfDay())
      .snapshots();
  String? imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbfbfb),
      body: StreamBuilder(
        stream: _transactionStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Ada yang salah, kembali dalam beberapa saat",
              style: TextStyle(fontFamily: 'Poppins'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: apphijau,
                  ),
                ),
                const Text(
                  'Loading...',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                )
              ],
            );
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data?.docs.length == 0) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/icons/sad.png'),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Belum ada transaksi masuk :(',
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

          String totalPenghasilan = '0';
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            totalPenghasilan = (int.parse(totalPenghasilan) +
                    int.parse(snapshot.data!.docs[i]['totalBelanja']))
                .toString();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(25),
                child: Expanded(
                  child: Text(
                    'Total Penghasilan : Rp $totalPenghasilan',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: appBlack,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: appWhite,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Image.asset('assets/icons/deal.png')),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['namaBarang'],
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    color: appBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Rp ${snapshot.data!.docs[index]['totalBelanja']}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    color: appBlack,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  DateFormat('dd MMMM yyyy, HH:mm:ss').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      snapshot.data!.docs[index]['timestamp']
                                          .millisecondsSinceEpoch,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    color: appBlack,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
