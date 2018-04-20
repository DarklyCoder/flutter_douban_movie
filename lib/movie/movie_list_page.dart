import 'package:flutter/material.dart';
import 'package:flutter_douban_movie/movie/movie.dart';
import 'package:flutter_douban_movie/movie/movie_detail_page.dart';

import 'dart:io';
import 'dart:convert';

class MovieListPage extends StatefulWidget {
  final String path;

  MovieListPage(this.path);

  @override
  MovieListPageState createState() => new MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    getMovieListData(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (movies.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: movies.length,
        itemBuilder: buildMovieItem,
      );
    }

    return new Scaffold(
      body: content,
    );
  }

  Widget buildMovieItem(BuildContext context, int index) {
    Movie movie = movies[index];

    var movieImage = new Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: new Image.network(
        movie.smallImage,
        width: 100.0,
        height: 120.0,
      ),
    );

    var movieMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(
          movie.title,
          textAlign: TextAlign.left,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        new Text('导演：' + movie.director),
        new Text('主演：' + movie.cast),
        new Text('评分：' + movie.average),
        new Text(
          movie.collectCount.toString() + '人看过',
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
          ),
        ),
      ],
    );

    var movieItem = new GestureDetector(
      //点击事件
      onTap: () => gotoMovieDetailPage(movie, index),

      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              movieImage,
              //Expanded 均分
              new Expanded(
                child: movieMsg,
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
          new Divider(),
        ],
      ),
    );

    return movieItem;
  }

  getMovieListData(String path) async {
    var url = 'https://api.douban.com' + path;
    try {
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var content = await response.transform(utf8.decoder).join();

        setState(() {
          movies = Movie.allFromResponse(content);
        });
      }
    } catch (exception) {
      print(exception);
    }
  }

  gotoMovieDetailPage(Movie movie, Object imageTag) {
    Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new MovieDetailPage(movie, imageTag: imageTag);
    }));
  }
}
