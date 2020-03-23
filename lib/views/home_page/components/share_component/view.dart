import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/ThemeStyle.dart';
import 'package:movie/generated/i18n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/actions/image_url.dart';
import 'package:movie/models/enums/image_size.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ShareState state, Dispatch dispatch, ViewService viewService) {
  final TextStyle _selectPopStyle = TextStyle(fontSize: Adapt.px(24), fontWeight: FontWeight.bold);
  final TextStyle _unselectPopStyle = TextStyle(fontSize: Adapt.px(24), color: Colors.grey);
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  Widget _buildShareCell(dynamic d) {
    return Padding(
      padding: EdgeInsets.only(left: Adapt.px(30)),
      key: ValueKey(d),
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
                      image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(d.photourl, ImageSize.w400)))),
            ),
            Container(
              width: Adapt.px(250),
              padding: EdgeInsets.all(Adapt.px(10)),
              child: Text(
                d.name ?? '',
                maxLines: 2,
                //textAlign: TextAlign.center,
                style: TextStyle(
                  //color: Colors.black,
                  fontSize: Adapt.px(26),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreCell() {
    return InkWell(
      onTap: null,
      child: Column(
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
                Text(I18n.of(viewService.context).more, style: TextStyle(fontSize: Adapt.px(35)),),
                Icon(Icons.arrow_forward, size: Adapt.px(35))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFrontTitle({EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20)}) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'New Share',
            style:
            TextStyle(fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () =>
                null,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () =>
                      dispatch(ShareActionCreator.onShareFilterChanged(true)),
                  child: Text(I18n.of(viewService.context).movies,
                      style: state.showShareMovie
                          ? _selectPopStyle
                          : _unselectPopStyle),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                GestureDetector(
                  onTap: () =>
                      dispatch(ShareActionCreator.onShareFilterChanged(false)),
                  child: Text(I18n.of(viewService.context).tvShows,
                      style: state.showShareMovie
                          ? _unselectPopStyle
                          : _selectPopStyle),
                )
              ],
            ),
          )
        ],
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: Adapt.px(20),
            ),
            Container(
              width: Adapt.px(200),
              height: Adapt.px(30),
              color: Colors.grey[200],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShareBody() {
    var model = state.showShareMovie
        ? (state.shareMovies?.data ?? [])
        : (state.shareTvshows?.data ?? []);
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: Container(
          key: ValueKey(model),
          height: Adapt.px(450),
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: PageScrollPhysics(),
            shrinkWrap: true,
            children: model.length > 0
                ? (model.map(_buildShareCell).toList()..add(_buildMoreCell()))
                : <Widget>[
              SizedBox(width: Adapt.px(20)),
              _buildShimmerCell(),
              SizedBox(width: Adapt.px(20)),
              _buildShimmerCell(),
              SizedBox(width: Adapt.px(20)),
              _buildShimmerCell(),
              SizedBox(width: Adapt.px(20)),
              _buildShimmerCell()
            ],
          ),
        ),
    );
  }



  return Column(
    children: <Widget>[
      _buildFrontTitle(),
      SizedBox(height: Adapt.px(30),),
      _buildShareBody(),
    ],
  );
}
