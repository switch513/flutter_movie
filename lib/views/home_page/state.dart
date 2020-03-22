import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/search_result.dart';

class HomePageState implements Cloneable<HomePageState> {
  VideoListModel movie;
  VideoListModel tv;
  SearchResultModel trending;
  VideoListModel popularMovies;
  VideoListModel popularTVShows;
  ScrollController scrollController;
  AnimationController animatedController;
  bool showHeaderMovie;

  @override
  HomePageState clone() {
    return HomePageState()
      ..tv = tv
      ..movie = movie
      ..trending = trending
      ..popularMovies = popularMovies
      ..popularTVShows = popularTVShows
      ..scrollController = scrollController
      ..animatedController = animatedController
      ..showHeaderMovie = showHeaderMovie;
  }
}

HomePageState initState(Map<String, dynamic> args) {
  var state = HomePageState();
  state.movie = VideoListModel.fromParams(results: List<VideoListResult>());
  state.tv = VideoListModel.fromParams(results: List<VideoListResult>());
  state.popularMovies =
  new VideoListModel.fromParams(results: List<VideoListResult>());
  state.popularTVShows =
  new VideoListModel.fromParams(results: List<VideoListResult>());
  state.showHeaderMovie = true;
  state.trending = SearchResultModel.fromParams(results: []);
  return state;
}
