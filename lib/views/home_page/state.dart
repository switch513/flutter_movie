import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

class HomePageState implements Cloneable<HomePageState> {
  VideoListModel movie;
  VideoListModel tv;
  VideoListModel popularMovies;
  VideoListModel popularTVShows;

  bool showHeaderMovie;

  @override
  HomePageState clone() {
    return HomePageState()
      ..tv = tv
      ..movie = movie
      ..popularMovies = popularMovies
      ..popularTVShows = popularTVShows
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
  return state;
}
