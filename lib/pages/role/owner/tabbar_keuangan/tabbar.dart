// ignore_for_file: unused_field, library_private_types_in_public_api, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:beautips/pages/role/owner/owner_profile.dart';
import 'package:beautips/pages/role/owner/tabbar_keuangan/all.dart';
import 'package:beautips/pages/role/owner/tabbar_keuangan/today.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerTabbarLaporanKeuangan extends StatelessWidget {
  const OwnerTabbarLaporanKeuangan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apphijau,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: apphijau,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        child: Image.asset('assets/icons/deal.png')),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 90,
                    height: 90,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Laporan Keuangan',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  tabs: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Tab(text: 'Hari ini')),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Tab(text: 'Semua')),
                  ]),
            ),
            Expanded(
              child: TabBarView(children: [
                const KeuanganHariIni(),
                KeuanganSemua(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
