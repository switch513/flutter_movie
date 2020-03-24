import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/douban/new_movies.dart';
import 'package:movie/style/ThemeStyle.dart';
import 'package:movie/models/video_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/actions/image_url.dart';
import 'package:movie/models/enums/image_size.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(PopularPosterState state, Dispatch dispatch, ViewService viewService) {
  final TextStyle _selectPopStyle = TextStyle(
    fontSize: Adapt.px(24),
    fontWeight: FontWeight.bold,
  );

  final TextStyle _unselectPopStyle =
  TextStyle(fontSize: Adapt.px(24), color: Colors.grey);

  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  Widget _buildFrontTitel(String title, Widget action,
      {EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 20)}) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              //color: Colors.black,
                fontSize: Adapt.px(35),
                fontWeight: FontWeight.bold),
          ),
          action
        ],
      ),
    );
  }

  Widget _buildCell(NewSubjects d) {
    return Padding(
      key: ValueKey(d.id),
      padding: EdgeInsets.only(left: Adapt.px(30)),
      child: GestureDetector(
        onTap: null,
        child: Column(
          children: <Widget>[
            Container(
                width: Adapt.px(250),
                height: Adapt.px(350),
                decoration: BoxDecoration(
                    color: _theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(Adapt.px(15)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(d.images.small)))),
            Container(
              //alignment: Alignment.bottomCenter,
                width: Adapt.px(250),
                padding: EdgeInsets.all(Adapt.px(10)),
                child: Text(
                  d.title ?? d.originalTitle,
                  maxLines: 2,
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Adapt.px(28),
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildMoreCell() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
          decoration: BoxDecoration(
            color: _theme.primaryColorLight,
            borderRadius: BorderRadius.circular(Adapt.px(15)),
          ),
          width: Adapt.px(250),
          height: Adapt.px(350),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  I18n.of(viewService.context).more,
                  style: TextStyle(fontSize: Adapt.px(35)),
                ),
                Icon(Icons.arrow_forward, size: Adapt.px(35))
              ]),
        )
      ],
    );
  }

  Widget _buildShimmerCell() {
    return SizedBox(
      width: Adapt.px(250),
      height: Adapt.px(350),
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          children: <Widget>[
            Container(
              width: Adapt.px(250),
              height: Adapt.px(350),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(Adapt.px(15)),
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Container(
              width: Adapt.px(250),
              height: Adapt.px(30),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(Adapt.px(15)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildbody() {
    NewMovies model =
        state.popularMoives;
    return AnimatedSwitcher(
        transitionBuilder: (widget, animated) {
          return SlideTransition(
            position:
            animated.drive(Tween(begin: Offset(1, 0), end: Offset.zero)),
            child: widget,
          );
        },
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        duration: Duration(milliseconds: 300),
        child: Container(
          key: ValueKey(model),
          height: Adapt.px(450),
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: PageScrollPhysics(),
            shrinkWrap: true,
            children: model.subjects.length > 0
                ? (model.subjects.map(_buildCell).toList()
              ..add(_buildMoreCell()))
                : <Widget>[
              SizedBox(
                width: Adapt.px(20),
              ),
              _buildShimmerCell(),
              SizedBox(
                width: Adapt.px(20),
              ),
              _buildShimmerCell(),
              SizedBox(
                width: Adapt.px(20),
              ),
              _buildShimmerCell(),
              SizedBox(
                width: Adapt.px(20),
              ),
              _buildShimmerCell()
            ],
          ),
        ));
  }

  return Column(
    children: <Widget>[
      _buildFrontTitel(
          '新片榜',
          Row(
            children: <Widget>[

            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30))),
      SizedBox(
        height: Adapt.px(30),
      ),
      _buildbody(),
    ],
  );
}
