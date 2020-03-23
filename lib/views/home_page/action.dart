import 'package:fish_redux/fish_redux.dart';

import 'package:movie/models/video_list.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';

//TODO replace with your own action
enum HomePageAction {
  action,
  initMovie,
  initTV,
  initPopularMovies,
  initPopularTVShows,
  cellTapped,
  searchBarTapped,
  initTrending,
  shareMore,
  initShareMovies,
  initShareTvShows,
}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }

  static Action onInitMovie(VideoListModel movie) {
    return Action(HomePageAction.initMovie, payload: movie);
  }

  static Action onInitTV(VideoListModel tv) {
    return Action(HomePageAction.initTV, payload: tv);
  }

  static Action onInitPopularMovie(VideoListModel pop) {
    return Action(HomePageAction.initPopularMovies, payload: pop);
  }

  static Action onInitPopularTV(VideoListModel pop) {
    return Action(HomePageAction.initPopularTVShows, payload: pop);
  }

  static Action onSearchBarTapped() {
    return const Action(HomePageAction.searchBarTapped);
  }

  static Action onCellTapped(int id, String bgpic, String title, String posterpic, MediaType type) {
    return  Action(HomePageAction.cellTapped, payload: [id, bgpic, title, posterpic, type]);
  }

  static Action initTrending(SearchResultModel d) {
    return Action(HomePageAction.initTrending, payload: d);
  }

  static Action onShareMore() {
    return const Action(HomePageAction.shareMore);
  }

  static Action initShareMovies(BaseMovieModel d) {
    return Action(HomePageAction.initShareMovies, payload: d);
  }

  static Action initShareTvShows(BaseTvShowModel d) {
    return Action(HomePageAction.initShareTvShows, payload: d);
  }
}
