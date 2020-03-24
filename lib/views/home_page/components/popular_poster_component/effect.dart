import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<PopularPosterState> buildEffect() {
  return combineEffects(<Object, Effect<PopularPosterState>>{
    PopularPosterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PopularPosterState> ctx) {
}
