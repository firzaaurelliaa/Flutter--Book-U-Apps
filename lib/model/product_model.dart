import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  DocumentReference docRef;
  String id;
  String namaProduct;
  String deskripsi;
  String fotoProduct;
  String hargaProduct;

  ProductModel({
    required this.docRef,
    required this.id,
    required this.namaProduct,
    required this.deskripsi,
    required this.fotoProduct,
    required this.hargaProduct,
  });

  factory ProductModel.fromJson(DocumentSnapshot snapshot) {
    return ProductModel(
      docRef: snapshot.reference,
      id: snapshot.id,
      namaProduct: snapshot['novel']['namaProduct'],
      deskripsi: snapshot['novel']['deskripsi'],
      fotoProduct: snapshot['novel']['fotoProduct'],
      hargaProduct: snapshot['novel']['hargaProduct'],
    );
  }
}

class PelajaranModel {
  DocumentReference docRef;
  String id;
  String namaProduct;
  String deskripsi;
  String fotoProduct;
  String hargaProduct;

  PelajaranModel({
    required this.docRef,
    required this.id,
    required this.namaProduct,
    required this.deskripsi,
    required this.fotoProduct,
    required this.hargaProduct,
  });

  factory PelajaranModel.fromJson(DocumentSnapshot snapshot) {
    return PelajaranModel(
      docRef: snapshot.reference,
      id: snapshot.id,
      namaProduct: snapshot['pelajaran']['namaProduct'],
      deskripsi: snapshot['pelajaran']['deskripsi'],
      fotoProduct: snapshot['pelajaran']['fotoProduct'],
      hargaProduct: snapshot['pelajaran']['hargaProduct'],
    );
  }
}
