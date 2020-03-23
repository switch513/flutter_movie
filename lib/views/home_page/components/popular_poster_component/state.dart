import 'package:fish_redux/fish_redux.dart';

class PopularPosterState implements Cloneable<PopularPosterState> {

  @override
  PopularPosterState clone() {
    return PopularPosterState();
  }
}

PopularPosterState initState(Map<String, dynamic> args) {
  return PopularPosterState();
}
