import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';
import 'package:movie/views/home_page/state.dart';

class ShareState implements Cloneable<ShareState> {
  BaseMovieModel shareMovies;
  BaseTvShowModel shareTvshows;
  bool showShareMovie;

  @override
  ShareState clone() {
    return ShareState()
      ..shareMovies = shareMovies
      ..shareTvshows = shareTvshows
      ..showShareMovie = showShareMovie;
  }
}

class ShareConnectior extends ConnOp<HomePageState, ShareState> {
  @override
  ShareState get(HomePageState state) {
    ShareState mstate = ShareState();
    mstate.shareMovies = state.shareMovies;
    mstate.shareTvshows = state.shareTvShows;
    mstate.showShareMovie = state.showShareMovie;
    return mstate;
  }

  void set(HomePageState state, ShareState subState) {
    state.showShareMovie = subState.showShareMovie;
  }
}
