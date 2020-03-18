import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/generated/i18n.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>> {
      GlobalAction.changeThemeColor: _onChangeThemeColor,
      GlobalAction.changeLocale: _onChangeLocale,
      GlobalAction.setUser: _onSetUser,
    }
  );
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onChangeThemeColor(GlobalState state, Action action) {
  final Color next = _colors[((_colors.indexOf(state.themeColor) + 1) % _colors.length)];
  return state.clone()..themeColor = next;
}

GlobalState _onChangeLocale(GlobalState state, Action action) {
  final Locale locale = action.payload;
  I18n.locale = locale;
  return state.clone()..locale = locale;
}

GlobalState _onSetUser(GlobalState state, Action action) {
  final FirebaseUser user = action.payload;
  return state.clone()..user = user;
}