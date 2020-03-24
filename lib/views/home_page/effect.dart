import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/ApiHelper.dart';
import 'package:movie/actions/douban/api_helper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/customwidgets/searchbar_delegate.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/actions/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    HomePageAction.action: _onAction,
    HomePageAction.searchBarTapped: _onSearchBarTapped,
    HomePageAction.cellTapped: _onCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {}

void _onSearchBarTapped(Action action, Context<HomePageState> ctx) async {
  await showSearch(context: ctx.context, delegate: SearchBarDelegate());
}

Future _onCellTapped(Action action, Context<HomePageState> ctx) async {
  final int id = action.payload[0];
  var data = {
    'id': id
  };

}

Future _onInit(Action action, Context<HomePageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animatedController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));

  ctx.state.scrollController = new ScrollController();

  final r = await DoubanApi.getInTheaters(city : '重庆');
  if (r != null) ctx.dispatch(HomePageActionCreator.onInitMovie(r));

  final s = await DoubanApi.getComingSoon();
  if (s != null) ctx.dispatch(HomePageActionCreator.onInitTV(s));

  final trending = await DoubanApi.getWeekly();
  if (trending != null)
    ctx.dispatch(HomePageActionCreator.initTrending(trending));

  final shareMovie = await DoubanApi.getUsBox();
  if (shareMovie != null)
    ctx.dispatch(HomePageActionCreator.initShareMovies(shareMovie));

  final p = await DoubanApi.getNewMovies();
  if (p != null) ctx.dispatch(HomePageActionCreator.onInitPopularMovie(p));

}

void _onDispose(Action action, Context<HomePageState> ctx) {
  ctx.state.animatedController.dispose();
  ctx.state.scrollController.dispose();
}