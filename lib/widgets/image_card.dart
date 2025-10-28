import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key});
 
  @override
  Widget build(BuildContext context) {
    const apiKey = String.fromEnvironment("API_KEY");
    if (apiKey.isEmpty) {
      throw Exception("API_KEY not found");
    }
    return ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: Column(
            children: [
              // Image.network(
              //   "https://images.pexels.com/photos/34385548/pexels-photo-34385548.jpeg",
              //   fit: BoxFit.contain,
              //   ),
              Text("API_KEY: $apiKey"),
            ],
          ),
        );
  }
}