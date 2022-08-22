import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/response_movie.dart';
import '../model/response_tv.dart';

String base = "https://api.themoviedb.org/3";
String apiKey = 'ca097bbfb936488fa086f014cbde2ac6';

class Api {
  Future<List<Result>> getMoviePopular(String category) async {
    var url = Uri.parse(
        '$base/movie/$category?api_key=$apiKey&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var urlResponse = Movie.fromJson(jsonDecode(response.body));
      return urlResponse.results;
    } else {
      throw Exception(response.statusCode);
    }
  }
}

class API {
  Future<List<Tv>> getTvPopular(String category) async {
    var url =
        Uri.parse('$base/tv/$category?api_key=$apiKey&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var urlResponse = Welcome.fromJson(jsonDecode(response.body));
      return urlResponse.results;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
