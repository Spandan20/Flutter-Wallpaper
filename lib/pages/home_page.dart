import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/image_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _futurePhotos;

  Future<List<dynamic>> fetchPhotos() async {
    const apiKey = String.fromEnvironment("API_KEY");
    if (apiKey.isEmpty) {
      throw Exception("API_KEY not found");
    }
    const uri = "https://api.pexels.com/v1/search?query=people";
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          "Authorization": apiKey
        }
      );
      if (response.statusCode == 200) {
        final Map<String,dynamic> data = jsonDecode(response.body);
        return data['photos'];
      }
      else {
        throw Exception("Error loading photos: ${response.statusCode}");
      }
    } catch(e) {
      throw Exception("Error: $e");
    }
  } 

  @override
  void initState() {
    super.initState();
    _futurePhotos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Wallpapers"))
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futurePhotos,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (asyncSnapshot.hasError) {
            return Center(child: Text("Error: ${asyncSnapshot.error}"));
          }

          else if (asyncSnapshot.hasData) {
             final photoList = asyncSnapshot.data!;
            if (photoList.isEmpty) {
              return const Center(child: Text("No photos found"));
            }
          
            return GridView.builder(
              itemCount: photoList.length,
              padding: EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.75
                ), 
              itemBuilder: (context, index) {
                final photo = photoList[index];
                final imageUrl = photo['src']['medium'];
                return ImageCard(uri: imageUrl);
              },
              );
          }
          else {
            return const Center(child: Text("No data found."));
          }
        }
      )
    );
  }
}