import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/image_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _futurePhotos;
  final ScrollController _scrollController = ScrollController();

  ApiService apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
    var page = 1;
    _futurePhotos = apiService.fetchPhotos(page: page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        page++;
        Future<List<dynamic>> newPhotos =  apiService.fetchPhotos(page: page);
        setState(() {
          _futurePhotos = newPhotos;
        });

      }
    });
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
              controller: _scrollController,
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