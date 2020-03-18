import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  Locale get locale;
  set locale(Locale locale);

  FirebaseUser get user;
  set user(FirebaseUser user);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;

  @override
  GlobalState clone() {
    // TODO: implement clone
    return GlobalState()
      ..themeColor = themeColor
      ..locale = locale
      ..user = user;
  }

}