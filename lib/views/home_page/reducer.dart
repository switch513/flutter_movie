import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePageState>>{
      HomePageAction.action: _onAction,
      HomePageAction.initMovie: _onInitMovie,
      HomePageAction.initTV: _onInitTV,
      HomePageAction.initTrending: _onInitTrending,
      HomePageAction.initPopularMovies: _onInitPopularMovie,
      HomePageAction.initPopularTVShows: _onInitPopularTVShows,
      HomePageAction.initShareMovies: _onInitShareMovies,
      HomePageAction.initShareTvShows: _onInitShareTvShows,
    },
  );
}

HomePageState _onAction(HomePageState state, Action action) {
  final HomePageState newState = state.clone();
  return newState;
}

HomePageState _onInitMovie(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.movie = model;
  return newState;
}

HomePageState _onInitTV(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.tv = model;
  return newState;
}

HomePageState _onInitPopularMovie(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.popularMovies = model;
  return newState;
}

HomePageState _onInitPopularTVShows(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.popularTVShows = model;
  return newState;
}

HomePageState _onInitTrending(HomePageState state, Action action) {
  final SearchResultModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.trending = model;
  return newState;
}

HomePageState _onInitShareMovies(HomePageState state, Action action) {
  final BaseMovieModel d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareMovies = d;
  return newState;
}

HomePageState _onInitShareTvShows(HomePageState state, Action action) {
  final BaseTvShowModel d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareTvShows = d;
  return newState;
}