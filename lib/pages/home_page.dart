import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Wallpapers"))
      ),
      body: Center(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
            child: Image.network(
              "https://images.pexels.com/photos/34385548/pexels-photo-34385548.jpeg",
              width: 400,
              height: 600,
              fit: BoxFit.cover,
              ),
          ),
        ),
    );
  }
}