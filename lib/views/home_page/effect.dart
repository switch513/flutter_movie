import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/ApiHelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/customwidgets/searchbar_delegate.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/enums/media_type.dart';
import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    HomePageAction.action: _onAction,
    HomePageAction.searchBarTapped: _onSearchBarTapped,

    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {}

void _onSearchBarTapped(Action action, Context<HomePageState> ctx) async {
  await showSearch(context: ctx.context, delegate: SearchBarDelegate());
}

Future _onInit(Action action, Context<HomePageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animatedController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));
  ctx.state.scrollController = new ScrollController();
  final r = await ApiHelper.getNowPlayingMovie();
  if (r != null) ctx.dispatch(HomePageActionCreator.onInitMovie(r));
  final s = await ApiHelper.getTVOnTheAir();
  if (s != null) ctx.dispatch(HomePageActionCreator.onInitTV(s));
  final trending = await ApiHelper.getTrending(MediaType.all, TimeWindow.day);
  if (trending != null)
    ctx.dispatch(HomePageActionCreator.initTrending(trending));
}

void _onDispose(Action action, Context<HomePageState> ctx) {
  ctx.state.animatedController.dispose();
  ctx.state.scrollController.dispose();
}