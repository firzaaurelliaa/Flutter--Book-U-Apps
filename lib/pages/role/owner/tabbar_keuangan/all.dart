// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  DateTime startOfDay() {
    // ignore: unnecessary_this
    return DateTime(this.year, this.month, this.day);
  }

  DateTime endOfDay() {
    return DateTime(this.year, this.month, this.day, 23, 59, 59, 999);
  }
}

class KeuanganSemua extends StatefulWidget {
  KeuanganSemua({Key? key}) : super(key: key);

  @override
  _KeuanganSemuaState createState() => _KeuanganSemuaState();
}

class _KeuanganSemuaState extends State<KeuanganSemua> {
  final Stream<QuerySnapshot> _transactionStream = FirebaseFirestore.instance
      .collection('transaction')
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
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              color: apphijau,
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 100,
                decoration: BoxDecoration(
                    color: appWhite, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
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
                            'Rp. ' +
                                snapshot.data!.docs[index]['totalBelanja']
                                    .toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: appBlack,
                              fontWeight: FontWeight.bold,
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
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: appBlack,
                            ),
                          ),
                          const SizedBox(width: 5),
                        ]),
                  ],
                ),
              );
            },  
          );
        },
      ),
    );
  }
}
