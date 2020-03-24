import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/douban/new_movies.dart';
import 'package:movie/models/douban/us_box.dart';
import 'package:movie/models/douban/weekly.dart';

import 'package:movie/models/video_list.dart';
import 'package:movie/models/douban/Theater.dart';
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
  moreTapped,
  initTrending,
  searchBarTapped,
  cellTapped,
  trendingMore,
  shareMore,
  initShareMovies,
  initShareTvShows,
}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }

  static Action onInitMovie(Threater movie) {
    return Action(HomePageAction.initMovie, payload: movie);
  }

  static Action onInitTV(Threater tv) {
    return Action(HomePageAction.initTV, payload: tv);
  }

  static Action onInitPopularMovie(NewMovies pop) {
    return Action(HomePageAction.initPopularMovies, payload: pop);
  }

  static Action onInitPopularTV(VideoListModel pop) {
    return Action(HomePageAction.initPopularTVShows, payload: pop);
  }

  static Action onMoreTapped(VideoListModel model, MediaType t) {
    return Action(HomePageAction.moreTapped, payload: [model, t]);
  }

  static Action initTrending(Weekly d) {
    return Action(HomePageAction.initTrending, payload: d);
  }

  static Action onSearchBarTapped() {
    return const Action(HomePageAction.searchBarTapped);
  }

  static Action onCellTapped(int id) {
    return Action(HomePageAction.cellTapped, payload: [id]);
  }

  static Action onTrendingMore() {
    return const Action(HomePageAction.trendingMore);
  }

  static Action onShareMore() {
    return const Action(HomePageAction.shareMore);
  }

  static Action initShareMovies(UsBox d) {
    return Action(HomePageAction.initShareMovies, payload: d);
  }

  static Action initShareTvShows(BaseTvShowModel d) {
    return Action(HomePageAction.initShareTvShows, payload: d);
  }
}
