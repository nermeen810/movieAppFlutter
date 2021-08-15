
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'Movies.dart';

class FetchMovieList extends ChangeNotifier{

  List<MovieResults> _movie=[];

  get movies => _movie;
  Future<List<MovieResults>>fetchMovies(String link) async{
     _movie = [];
    final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/'+link+'?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1');
    if (response.statusCode == 200) {
      for (var item in response.data['results']) {
        print(MovieResults.fromJson(item));
        MovieResults result = MovieResults.fromJson(item);
        print("Movie Name ${result.originalTitle}");
        _movie.add(result);
      }
      notifyListeners();
      return movies;
    }
    else {
    throw Exception('Failed to load movie');
    }
  }
}
