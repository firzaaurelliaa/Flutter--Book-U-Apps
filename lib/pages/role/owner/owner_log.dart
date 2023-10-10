// ignore_for_file: prefer_const_constructors

import 'package:beautips/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LogActivity extends StatefulWidget {
  @override
  _LogActivityState createState() => _LogActivityState();
}

class _LogActivityState extends State<LogActivity> {
  List<String> _logs = [];

  void _logActivity(String activity) {
    setState(() {
      _logs.add(activity);
    });

    _firestore.collection('log').add({
      'activity': activity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appWhite,
        title: Text(
          'Laporan Aktivitas',
          style: TextStyle(
            color: appBlack,
            fontFamily: 'Poppins',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('log')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: apphijau,
              ),
            );
          }
          List logs =
              snapshot.data!.docs.map((doc) => doc['activity']).toList();
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = snapshot.data!.docs[index];
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
                          margin: EdgeInsets.all(5),
                          child: Image.asset('assets/icons/time2.png')),
                    ),
                    const SizedBox(width: 10),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.docs[index]['activity'],
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: appBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            (log['timestamp'] != null)
                                ? DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(log['timestamp'].toDate())
                                : 'Timestamp is null',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: appBlack,
                            ),
                          ),
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
