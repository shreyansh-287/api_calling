import 'dart:async';
import 'dart:convert';
import 'package:api_calling/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  if (response.statusCode == 200) {
    final jsonData_ = jsonDecode(response.body);
    List<dynamic> jsonData = jsonData_['products'];
    return jsonData.map((item) => Album.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int? id;
  final String title; //
  final String? description;
  final int? price;
  final double? discountPercentage; //
  final double? rating; //
  final int? stock; //
  final String? brand; //
  final String? category; //
  final Uri? thumbnail;
  final List<Uri>? images;

  const Album({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: Uri.parse(json['thumbnail']),
      images: (json['images'] as List<dynamic>)
          .map((image) => Uri.parse(image))
          .toList(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Album> products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    Album product = products[index];
                    return ListTile(
                      leading: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.network(product.thumbnail.toString())),
                      title: Text(product.title),
                      subtitle:
                          Text('Available Stock: ${product.stock.toString()}'),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoScreen(
                                product.description.toString(),
                                product.price,
                                product.thumbnail.toString(),
                                product.title,
                                product.discountPercentage,
                                product.rating,
                                product.stock,
                                product.brand,
                                product.category,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.info),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}