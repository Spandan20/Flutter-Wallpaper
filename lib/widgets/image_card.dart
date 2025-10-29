import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final uri;
  const ImageCard({super.key, required this.uri});
 
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: Image.network(
                uri,
                fit: BoxFit.cover,
                ),
        );
  }
}