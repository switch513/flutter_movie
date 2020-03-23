import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';

class HomePageState implements Cloneable<HomePageState> {
  VideoListModel movie;
  VideoListModel tv;
  SearchResultModel trending;
  VideoListModel popularMovies;
  VideoListModel popularTVShows;
  ScrollController scrollController;
  AnimationController animatedController;
  bool showHeaderMovie;
  bool showShareMovie;
  BaseMovieModel shareMovies;
  BaseTvShowModel shareTvShows;

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
      ..shareMovies = shareMovies
      ..shareTvShows = shareTvShows
      ..showShareMovie = showShareMovie
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
  state.shareMovies = BaseMovieModel.fromParams(data: List<BaseMovie>());
  state.shareTvShows = BaseTvShowModel.fromParams(data: List<BaseTvShow>());
  state.trending = SearchResultModel.fromParams(results: []);
  state.showShareMovie = true;
  return state;
}
