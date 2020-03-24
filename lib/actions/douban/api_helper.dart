import 'dart:io';

import 'package:movie/actions/request.dart';
import 'package:movie/models/douban/Theater.dart';
import 'package:movie/models/douban/movie_info.dart';
import 'package:movie/models/douban/new_movies.dart';
import 'package:movie/models/douban/us_box.dart';
import 'package:movie/models/douban/weekly.dart';

class DoubanApi {
  static Request _http = Request('https://api.douban.com/');

  static Future<Threater> getInTheaters({String city = '北京'}) async {
    Threater model;
    String param = 'v2/movie/in_theaters?city=$city&apikey=0df993c66c0c636e29ecbb5344252a4a';
    var r = await _http.request(param);
    if (r != null) model = Threater(r);
    return model;
  }

  static Future<Threater> getComingSoon({int start = 1, int count = 20}) async {
    Threater model;
    String param = 'v2/movie/coming_soon?start=$start&count=$count&apikey=0df993c66c0c636e29ecbb5344252a4a';
    var r = await _http.request(param);
    if (r != null) model = Threater(r);
    return model;
  }

  static Future<Weekly> getWeekly() async {
    Weekly model;
    String param = 'v2/movie/weekly?apikey=0df993c66c0c636e29ecbb5344252a4a';
    var r = await _http.request(param);
    if (r != null) model = Weekly(r);
    return model;
  }

  static Future<UsBox> getUsBox() async {
    UsBox model;
    String param = 'v2/movie/us_box?apikey=0df993c66c0c636e29ecbb5344252a4a';
    var r = await _http.request(param);
    if (r != null) model = UsBox(r);
    return model;
  }

  static Future<NewMovies> getNewMovies() async {
    NewMovies model;
    String param = 'v2/movie/new_movies?apikey=0df993c66c0c636e29ecbb5344252a4a';
    var r = await _http.request(param);
    if (r != null) model = NewMovies(r);
    return model;
  }

  static Future<MovieInfo> getMoviesInfo(int id) async {
    MovieInfo model;
    String param = 'v2/movie/subject/$id?apikey=0df993c66c0c636e29ecbb5344252a4a';
    var r = await _http.request(param);
    if (r != null) model = MovieInfo(r);
    return model;
  }

}