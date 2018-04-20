import 'package:flutter/material.dart';
import 'package:flutter_douban_movie/movie/movie_list_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: buildHomePage(context),
    );
  }
}

Widget buildHomePage(BuildContext context) {
  return new DefaultTabController(
    length: mocieTabs.length,
    child: new Scaffold(
      appBar: new AppBar(
        title: const Text('豆瓣电影'),
        bottom: new TabBar(
          isScrollable: true,
          tabs: mocieTabs.map((MovieTab movieTab) {
            return new Tab(
              text: movieTab.title,
            );
          }).toList(),
        ),
      ),
      body: new TabBarView(
        children: mocieTabs.map((MovieTab movieTab) {
          return new Padding(
            padding: const EdgeInsets.all(1.0),
            child: new MovieListPage(movieTab.path),
          );
        }).toList(),
      ),
    ),
  );
}

class MovieTab {
  final String title;
  final String path;
  const MovieTab({this.title, this.path});
}

const List<MovieTab> mocieTabs = const <MovieTab>[
  const MovieTab(title: '正在热映', path: '/v2/movie/in_theaters'),
  const MovieTab(title: '即将上映', path: '/v2/movie/coming_soon'),
  const MovieTab(title: 'Top250', path: '/v2/movie/top250'),
  const MovieTab(title: '口碑榜', path: '/v2/movie/weekly'),
  const MovieTab(title: '北美票房榜', path: '/v2/movie/us_box'),
  const MovieTab(title: '新片榜', path: '/v2/movie/new_movies'),
];
