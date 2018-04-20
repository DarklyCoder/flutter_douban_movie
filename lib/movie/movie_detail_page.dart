import 'package:flutter/material.dart';
import 'package:flutter_douban_movie/movie/movie.dart';

//电影详情界面
class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final Object imageTag;

  MovieDetailPage(this.movie, {this.imageTag});

  @override
  MovieDetailPageState createState() => new MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.movie.title),
      ),
      body: buildUI(widget.movie),
    );
  }

  Widget buildUI(Movie movieDetail) {
    var movieImage = new Hero(
      tag: widget.imageTag,
      child: new Center(
        child: new Image.network(
          movieDetail.smallImage,
          width: 120.0,
          height: 140.0,
        ),
      ),
    );

    var movieMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(
          movieDetail.title,
          textAlign: TextAlign.left,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        new Text('导演：' + movieDetail.director),
        new Text('主演：' + movieDetail.cast),
        new Text(
          movieDetail.collectCount.toString() + '人看过',
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
          ),
        ),
        new Text('评分：' + movieDetail.average.toString()),
        new Text(
          '剧情简介：' + movieDetail.director,
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ],
    );

    return new Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: new Scrollbar(
        child: new Column(
          children: <Widget>[
            movieImage,
            movieMsg,
          ],
        ),
      ),
    );
  }
}
