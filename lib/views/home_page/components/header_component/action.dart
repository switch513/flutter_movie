import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HeaderAction {
  action,
  headerFilterChanged,
}

class HeaderActionCreator {
  static Action onAction() {
    return const Action(HeaderAction.action);
  }

  static Action onHeaderFilterChanged(bool e) {
    return Action(HeaderAction.headerFilterChanged, payload: e);
  }
}
