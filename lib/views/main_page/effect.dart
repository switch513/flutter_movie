import 'package:fish_redux/fish_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie/actions/ApiHelper.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<MainPageState> ctx) {
}

void _onInit(Action action, Context<MainPageState> ctx) async {
  await ApiHelper.init();
  var _user = await FirebaseAuth.instance.currentUser();
  if (_user != null) {
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(_user));
  }
}
