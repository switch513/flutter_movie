import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/douban/new_movies.dart';
import 'package:movie/models/douban/us_box.dart';
import 'package:movie/models/douban/weekly.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/douban/Theater.dart';
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
      HomePageAction.initPopularMovies: _onInitPopularMovie,
      HomePageAction.initTrending: _onInitTrending,
      HomePageAction.initShareMovies: _onInitShareMovies,
    },
  );
}

HomePageState _onAction(HomePageState state, Action action) {
  final HomePageState newState = state.clone();
  return newState;
}

HomePageState _onInitMovie(HomePageState state, Action action) {
  final Threater model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.movie = model;
  return newState;
}

HomePageState _onInitTV(HomePageState state, Action action) {
  final Threater model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.tv = model;
  return newState;
}

HomePageState _onInitPopularMovie(HomePageState state, Action action) {
  final NewMovies model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.popularMovies = model;
  return newState;
}

HomePageState _onInitTrending(HomePageState state, Action action) {
  final Weekly model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.trending = model;
  return newState;
}

HomePageState _onInitShareMovies(HomePageState state, Action action) {
  final UsBox d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareMovies = d;
  return newState;
}
