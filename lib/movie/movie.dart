import 'dart:convert';
import 'package:meta/meta.dart';

class Movie {
  final String title;
  final String average;
  final int collectCount;
  final String smallImage;
  final String director;
  final String cast;
  final String movieId;

  //构造函数
  Movie({
    @required this.title,
    @required this.average,
    @required this.collectCount,
    @required this.smallImage,
    @required this.director,
    @required this.cast,
    @required this.movieId,
  });

  static List<Movie> allFromResponse(String content) {
    List list = json.decode(content)['subjects'];
    List<Movie> movies = [];

    for (int i = 0; i < list.length; i++) {
      movies.add(Movie.fromMap(list[i]));
    }

    return movies;
  }

  static Movie fromMap(Map map) {
    List directors = map['directors'];
    var d = '';
    for (int i = 0; i < directors.length; i++) {
      if (i == 0) {
        d = d + directors[i]['name'];
      } else {
        d = d + '/' + directors[i]['name'];
      }
    }

    List casts = map['casts'];
    var c = '';
    for (int i = 0; i < casts.length; i++) {
      if (i == 0) {
        c = c + casts[i]['name'];
      } else {
        c = c + '/' + casts[i]['name'];
      }
    }

    return new Movie(
      title: map['title'],
      average: map['rating']['average'].toString(),
      collectCount: map['collect_count'],
      smallImage: map['images']['small'],
      director: d,
      cast: c,
      movieId: map['id'],
    );
  }
}
