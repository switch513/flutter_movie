import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';
import 'package:movie/models/douban/us_box.dart';
import 'package:movie/views/home_page/state.dart';

class ShareState implements Cloneable<ShareState> {
  UsBox shareMovies;

  @override
  ShareState clone() {
    return ShareState()
      ..shareMovies = shareMovies;
  }
}

class ShareConnectior extends ConnOp<HomePageState, ShareState> {
  @override
  ShareState get(HomePageState state) {
    ShareState mstate = ShareState();
    mstate.shareMovies = state.shareMovies;
    return mstate;
  }

}
