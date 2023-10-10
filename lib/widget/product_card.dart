
import 'package:beautips/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String icon;
  final String name;
  final String desc;

  const ProductCard({
    required this.icon,
    required this.name,
    required this.desc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: Image.asset(icon),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appBlack,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: appBlack,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
