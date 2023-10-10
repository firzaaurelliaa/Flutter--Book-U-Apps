// ignore_for_file: sort_child_properties_last, prefer_is_empty


import 'package:beautips/pages/role/admin/kategori_barang/buku_cerita.dart';
import 'package:beautips/pages/role/admin/kategori_barang/buku_novel.dart';
import 'package:beautips/pages/role/admin/kategori_barang/buku_pelajaran.dart';
import 'package:beautips/pages/role/admin/kategori_barang/penggaris.dart';
import 'package:beautips/pages/role/admin/kategori_barang/penghapus.dart';
import 'package:beautips/pages/role/admin/kategori_barang/pulpen.dart';
import 'package:beautips/theme.dart';
import 'package:beautips/widget/product_card.dart';
import 'package:flutter/material.dart';

class AdminProduct extends StatelessWidget {
  const AdminProduct({Key? key}) : super(key: key);

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
                        builder: (context) => const AdminBukuNovel()),
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
                        builder: (context) => const AdminBukuPelajaran()),
                  );
                },
                child: const ProductCard(
                  icon: 'assets/icons/bp_.png',
                  name: 'Buku Pelajaran',
                  desc: 'Lorem ipsum dot amet',
                ),
              ), 
              // ignore: prefer_const_constructors
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminBukuCerita()),
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
                        builder: (context) => const AdminPulpen()),
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
                        builder: (context) => const AdminPenghapus()),
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
                        builder: (context) => const AdminPenggaris()),
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








// class AdminProductDesc extends StatefulWidget {
//   const AdminProductDesc({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<AdminProductDesc> createState() => _AdminProductDescState();
// }

// class _AdminProductDescState extends State<AdminProductDesc> {
//   final Stream<QuerySnapshot> _productStream =
//       FirebaseFirestore.instance.collection('product').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: appBackground,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AddProduct(id: 'id')),
//             );
//           },
//           child: const Icon(Icons.add),
//           backgroundColor: apphijau,
//         ),
//         appBar: AppBar(
//           title: Text(
//             'Data Barang',
//             style: TextStyle(
//               color: appBlack,
//               fontFamily: 'Poppins',
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: appWhite,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: appBlack,
//             ),
//           ),
//         ),
//         body: StreamBuilder(
//           stream: _productStream,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text("Ada yang salah");
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: apphijau,
//                 ),
//               );
//             }
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator(
//                 color: apphijau,
//               );
//             }
//             if (snapshot.data?.docs.length == 0) {
//               return Scaffold(
//                 backgroundColor: appWhite,
//                 body: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 175,
//                         height: 175,
//                         child: Image.asset('assets/icons/box.png'),
//                       ),
//                       const SizedBox(height: 15),
//                       Text(
//                         'Stok barang sedang kosong:(',
//                         style: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontFamily: 'Poppins',
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (_, index) {
//                 ProductModel productModel =
//                     ProductModel.fromJson(snapshot.data!.docs[index]);
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 30, right: 30),
//                   child: Column(
//                     children: [
//                       // ignore: prefer_const_constructors
//                       const SizedBox(height: 20.0),
//                       InkWell(
//                         onTap: () => {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AdminSpekProduct(
//                                 id: snapshot.data!.docs[index].id,
//                                 doc: snapshot.data!.docs[index],
//                                 namaProduct: productModel.namaProduct,
//                                 deskripsi: productModel.deskripsi,
//                                 docid: snapshot.data!.docs[index],
//                                 fotoProduct: productModel.fotoProduct,
//                                 hargaProduct: productModel.hargaProduct,
//                               ),
//                             ),
//                           ),
//                         },
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: 155.0,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.0),
//                             color: appWhite,
//                           ),
//                           child: Container(
//                             margin: const EdgeInsets.all(20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   flex: 80,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         productModel.namaProduct.toString(),
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: 'Poppins',
//                                             color: appBlack),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "Rp. ",
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'Poppins',
//                                               color: apphijau,
//                                             ),
//                                           ),
//                                           Text(
//                                             productModel.hargaProduct
//                                                 .toString(),
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               fontFamily: 'Poppins',
//                                               color: apphijau,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Expanded(
//                                         child: Text(
//                                           productModel.deskripsi.toString(),
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             fontFamily: 'Poppins',
//                                             color: appBlack,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 3,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 70,
//                                   height: 70,
//                                   child: (productModel.fotoProduct.toString() !=
//                                           'null')
//                                       ? Image.network(
//                                           productModel.fotoProduct,
//                                           fit: BoxFit.cover,
//                                           loadingBuilder: (BuildContext context,
//                                               Widget child,
//                                               ImageChunkEvent?
//                                                   loadingProgress) {
//                                             if (loadingProgress == null) {
//                                               return child;
//                                             }
//                                             return Center(
//                                               child: CircularProgressIndicator(
//                                                 color: apphijau,
//                                                 value: loadingProgress
//                                                             .expectedTotalBytes !=
//                                                         null
//                                                     ? loadingProgress
//                                                             .cumulativeBytesLoaded /
//                                                         loadingProgress
//                                                             .expectedTotalBytes!
//                                                     : null,
//                                               ),
//                                             );
//                                           },
//                                         )
//                                       : Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey[300]!,
//                                           ),
//                                           width: 150,
//                                           height: 150,
//                                           child: const Icon(
//                                             Icons.shopping_basket_rounded,
//                                             color: Colors.white,
//                                             size: 50,
//                                           ),
//                                         ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ));
//   }
// }
