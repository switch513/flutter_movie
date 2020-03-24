import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/douban/new_movies.dart';
import 'package:movie/models/douban/us_box.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/douban/Theater.dart';
import 'package:movie/models/douban/weekly.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';

class HomePageState implements Cloneable<HomePageState> {
  Threater movie;
  Threater tv;
  Weekly trending;
  NewMovies popularMovies;
  ScrollController scrollController;
  AnimationController animatedController;
  bool showHeaderMovie;
  UsBox shareMovies;

  @override
  HomePageState clone() {
    return HomePageState()
      ..tv = tv
      ..movie = movie
      ..trending = trending
      ..popularMovies = popularMovies
      ..scrollController = scrollController
      ..animatedController = animatedController
      ..shareMovies = shareMovies
      ..showHeaderMovie = showHeaderMovie;
  }
}

HomePageState initState(Map<String, dynamic> args) {
  var state = HomePageState();
  state.movie = new Threater.fromParams(subjects: List<Subjects>());
  state.tv = new Threater.fromParams(subjects: List<Subjects>());
  state.popularMovies =
  new NewMovies.fromParams(subjects: List<NewSubjects>());
  state.trending = Weekly.fromParams(subjects: List<WeeklySubjects>());
  state.shareMovies = UsBox.fromParams(subjects: List<UsSubjects>());
  state.showHeaderMovie = true;
  return state;
}
