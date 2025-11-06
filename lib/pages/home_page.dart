import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/image_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<dynamic> photoList = [];
  final ScrollController _scrollController = ScrollController();

  ApiService apiService = ApiService();
  int page = 1; 

  @override
  void initState() {
    super.initState();
    
    _fetchPhotos();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          _fetchPhotos();
        }
    });
  }

  Future<void> _fetchPhotos() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      final newPhotos = await apiService.fetchPhotos(page: page);
      if (newPhotos.isNotEmpty) {
        setState(() {
          photoList.addAll(newPhotos);
          page++;
          _isLoading = false;
        });
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Wallpapers"))
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
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
                      if (index == photoList.length) {
                      } 
                      else {
                        final photo = photoList[index];
                        final String imageUrl = photo['src']['tiny'];
                        return ImageCard(uri: imageUrl);
                      }
                    },
                    ),
          ),
                  if(_isLoading) 
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  
        ],
      )
    );
  }
}