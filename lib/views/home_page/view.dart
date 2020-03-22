import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/ThemeStyle.dart';

import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/backdrop.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(HomePageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);

      Widget _buildSearchBar() {
        return GestureDetector(
          onTap: () => dispatch(HomePageActionCreator.onSearchBarTapped()),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              height: Adapt.px(70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(40)),
                color: Color.fromRGBO(57, 57, 57, 1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  Text(
                    I18n.of(viewService.context).searchbartxt,
                    style:
                    TextStyle(color: Colors.grey, fontSize: Adapt.px(28)),
                  )
                ],
              )),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.bottomAppBarColor,
          brightness: Brightness.dark,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: _buildSearchBar(),
        ),
        body: BackDrop(
          height: Adapt.px(520),
          backChild: viewService.buildComponent('header'),
          frontBackGroundColor: _theme.backgroundColor,
          frontChild: Container(
            color: _theme.backgroundColor,
            child: ListView(
              dragStartBehavior: DragStartBehavior.down,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                viewService.buildComponent('swiper'),
                viewService.buildComponent('trending'),
              ],
            ),
          ),
        ),
      );
    },
  );
}
