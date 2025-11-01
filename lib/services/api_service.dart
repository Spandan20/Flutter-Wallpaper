import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchPhotos({required int page}) async {
    const apiKey = String.fromEnvironment("API_KEY");
    if (apiKey.isEmpty) {
      throw Exception("API_KEY not found");
    }
    const baseUri = "https://api.pexels.com/v1/curated?per_page=80";
    var uri = "$baseUri&page=$page";
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
}