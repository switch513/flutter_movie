import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TrendingState> buildReducer() {
  return asReducer(
    <Object, Reducer<TrendingState>>{
      TrendingAction.action: _onAction,
    },
  );
}

TrendingState _onAction(TrendingState state, Action action) {
  final TrendingState newState = state.clone();
  return newState;
}
