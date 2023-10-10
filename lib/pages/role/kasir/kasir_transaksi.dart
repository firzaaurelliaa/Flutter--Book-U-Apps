// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_const

import 'package:beautips/pages/role/kasir/kasir_invoice.dart';
import 'package:beautips/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KasirTransaksi extends StatefulWidget {
  final String namabarang;
  final String hargasatuan;
  const KasirTransaksi({
    Key? key,
    required this.namabarang,
    required this.hargasatuan,
  }) : super(key: key);

  @override
  _KasirTransaksiState createState() => _KasirTransaksiState();
}

class _KasirTransaksiState extends State<KasirTransaksi> {
  final TextEditingController _hargaSatuanController = TextEditingController();
  final TextEditingController _jumlahBarangController = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _namaPembeliController = TextEditingController();
  final TextEditingController _uangPembeliController = TextEditingController();

  String _totalBelanja = '0';
  String _kembalian = '0';

  @override
  void initState() {
    super.initState();
    _namaBarangController.text = widget.namabarang;
    _hargaSatuanController.text = widget.hargasatuan;
  }

  @override
  void dispose() {
    _hargaSatuanController.dispose();
    _jumlahBarangController.dispose();
    _namaBarangController.dispose();
    _namaPembeliController.dispose();
    _uangPembeliController.dispose();
    super.dispose();
  }

  void _hitungTotalBelanja() {
    final String hargaSatuan = _hargaSatuanController.text;
    final String jumlahBarang = _jumlahBarangController.text;
    setState(() {
      _totalBelanja =
          (int.parse(hargaSatuan) * int.parse(jumlahBarang)).toString();
    });
  }

  void _hitungKembalian() {
    final String uangPembeli = _uangPembeliController.text;

    setState(() {
      _kembalian =
          (int.parse(uangPembeli) - int.parse(_totalBelanja)).toString();
    });
  }

  void _reset() {
    setState(() {
      _totalBelanja = '0';
      _hargaSatuanController.text = widget.hargasatuan;
      _jumlahBarangController.text = '';
      _namaBarangController.text = widget.namabarang;
      _namaPembeliController.text = '';
      _uangPembeliController.text = '';
    });
  }

  Future<void> _simpanTransaksi() async {
    final int totalBelanja = int.parse(_totalBelanja);
    final int uangPembeli = int.parse(_uangPembeliController.text);

    if (uangPembeli >= totalBelanja) {
      final Map<String, dynamic> data = {
        'hargaSatuan': _hargaSatuanController.text,
        'jumlahBarang': _jumlahBarangController.text,
        'namaBarang': _namaBarangController.text,
        'namaPembeli': _namaPembeliController.text,
        'uangPembeli': _uangPembeliController.text,
        'totalBelanja': _totalBelanja,
        'kembalian': _kembalian,
        'timestamp': FieldValue.serverTimestamp()
      };
      await FirebaseFirestore.instance.collection('transaction').add(data);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Invoice()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal, uang pembeli tidak cukup',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: appWhite,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Form Transaksi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            color: appBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appWhite,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                controller: _namaBarangController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  labelText: 'Nama barang :',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: apphijau,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextField(
                readOnly: true,
                keyboardType: const TextInputType.numberWithOptions(),
                controller: _hargaSatuanController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  labelText: 'Harga Satuan :',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: apphijau,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: _jumlahBarangController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  labelText: 'Jumlah Barang :',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: apphijau,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _jumlahBarangController.clear,
                    icon: const Icon(Icons.clear),
                    color: apphijau,
                  ),
                ),
                onChanged: (value) => _hitungTotalBelanja(),
              ),
              const SizedBox(height: 25.0),
              TextField(
                controller: _namaPembeliController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  labelText: 'Nama Pembeli :',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: apphijau,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _namaPembeliController.clear,
                    icon: const Icon(Icons.clear),
                    color: apphijau,
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: _uangPembeliController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  labelText: 'Uang Pembeli :',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: apphijau,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _uangPembeliController.clear,
                    icon: const Icon(Icons.clear),
                    color: apphijau,
                  ),
                ),
                onChanged: (value) => _hitungKembalian(),
              ),
              const SizedBox(height: 25.0),
              Text(
                'Total Belanja: Rp. $_totalBelanja',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: appBlack,
                ),
              ),
              const SizedBox(height: 25.0),
              // Text(
              //   'Kembalian: Rp. $_kembalian',
              //   style: TextStyle(
              //     fontFamily: 'Poppins',
              //     fontSize: 17,
              //     fontWeight: FontWeight.bold,
              //     color: appBlack,
              //   ),
              // ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_namaPembeliController.text.isNotEmpty &&
                        _namaBarangController.text.isNotEmpty &&
                        _hargaSatuanController.text.isNotEmpty &&
                        _jumlahBarangController.text.isNotEmpty &&
                        _uangPembeliController.text.isNotEmpty) {
                      await _simpanTransaksi();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: const Text('Inputan tidak boleh kosong'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 38),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    primary: apphijau,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Beli',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    _reset();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 38),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    primary: Colors.transparent,
                    elevation: 0,
                    side: BorderSide(
                      width: 2,
                      color: apphijau,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: apphijau,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
