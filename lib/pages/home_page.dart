import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/image_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Wallpapers"))
      ),
      body: GridView.builder(
        itemCount: 1,
        padding: EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          ), 
        itemBuilder: (context, index) {
          return ImageCard();
        },
        )
    );
  }
}