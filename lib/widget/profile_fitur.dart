import 'package:flutter/material.dart';

class ProfilFitur extends StatelessWidget {
  const ProfilFitur({
    Key? key,
    required this.data,
    required this.isi,
  }) : super(key: key);

  final String data;
  final String isi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(height: 17.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                data,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                isi,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17.0),
        ],
      ),
    );
  }
}
