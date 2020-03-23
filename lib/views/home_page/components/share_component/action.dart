import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ShareAction {
  action,
  shareFilterChanged,
}

class ShareActionCreator {
  static Action onAction() {
    return const Action(ShareAction.action);
  }

  static Action onShareFilterChanged(bool e) {
    return Action(ShareAction.shareFilterChanged, payload: e);
  }
}
