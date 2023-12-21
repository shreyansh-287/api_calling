import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final String des;
  final String src; //
  final int? prc; //
  final String title; //
  final double? discountPercentage;
  final double? rating; //
  final int? stock; //
  final String? brand; //
  final String? category; //
  const InfoScreen(
      this.des,
      this.prc,
      this.src,
      this.title,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Info",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              'Product Description'),
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(src),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                    ),
                    category.toString(),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    title.toString(),
                  ),
                  Text(
                    style: const TextStyle(fontSize: 10),
                    '(${brand.toString()})',
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                    'Available: ${stock.toString()}',
                  ),
                  Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                    'Rating: ${rating.toString()}',
                  ),
                  Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                    'Price: \$ ${prc.toString()}',
                  ),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                    '(You Will Save ${discountPercentage.toString()}% on this deal)',
                  ),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  const Text(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    'About',
                  ),
                  Text(
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    des,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}