// ignore_for_file: prefer_is_empty, duplicate_ignore, avoid_print

import 'package:beautips/pages/role/kasir/kategori_barang/buku_cerita.dart';
import 'package:beautips/pages/role/kasir/kategori_barang/buku_novel.dart';
import 'package:beautips/pages/role/kasir/kategori_barang/buku_pelajaran.dart';
import 'package:beautips/pages/role/kasir/kategori_barang/penggaris.dart';
import 'package:beautips/pages/role/kasir/kategori_barang/penghapus.dart';
import 'package:beautips/pages/role/kasir/kategori_barang/pulpen.dart';
import 'package:beautips/theme.dart';
import 'package:beautips/widget/product_card.dart';
import 'package:flutter/material.dart';

class KasirProduct extends StatelessWidget {
  const KasirProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        title: Text(
          'Kategori Barang',
          style: TextStyle(
            color: appBlack,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appWhite,
      ),
      body: ListView(
        children: [
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KasirBukuNovel(),
                    ),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/book.png',
                  name: 'Buku Novel',
                  desc: 'Lorem ipsum dot amet',
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KasirBukuPelajaran(),
                    ),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/bp_.png',
                  name: 'Buku Pelajaran',
                  desc: 'Lorem ipsum dot amet',
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KasirBukuCerita(),
                    ),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/bc_.png',
                  name: 'Buku Cerita',
                  desc: 'Lorem ipsum dot amet',
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KasirPulpen(),
                    ),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/pen2.png',
                  name: 'Pulpen',
                  desc: 'Lorem ipsum dot amet',
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KasirPenghapus(),
                    ),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/eraser2.png',
                  name: 'Penghapus',
                  desc: 'Lorem ipsum dot amet',
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KasirPenggaris(),
                    ),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/ruler2.png',
                  name: 'Penggaris',
                  desc: 'Lorem ipsum dot amet',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
