import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PopularPosterAction { action }

class PopularPosterActionCreator {
  static Action onAction() {
    return const Action(PopularPosterAction.action);
  }
}
