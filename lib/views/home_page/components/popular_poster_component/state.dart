import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/douban/new_movies.dart';
import 'package:movie/models/video_list.dart';
import '../../state.dart';

class PopularPosterState implements Cloneable<PopularPosterState> {
  NewMovies popularMoives;
  @override
  PopularPosterState clone() {
    return PopularPosterState()
      ..popularMoives = popularMoives;
  }
}

class PopularPosterConnector extends ConnOp<HomePageState, PopularPosterState> {
  @override
  PopularPosterState get(HomePageState state) {
    PopularPosterState mstate = PopularPosterState();
    mstate.popularMoives = state.popularMovies;
    return mstate;
  }

}
