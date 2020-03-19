import 'package:fish_redux/fish_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/image_size.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/ThemeStyle.dart';

import 'package:movie/actions/image_url.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/views/home_page/action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(HeaderState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  Widget _buildHeaderTitle() {
    var _selectTextStyle = TextStyle(
      color: Colors.white,
      fontSize: Adapt.px(40),
      fontWeight: FontWeight.bold
    );
    
    var _unSelectTextStyle = TextStyle(
      color: Colors.grey, fontSize: Adapt.px(40)
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () => dispatch(HeaderActionCreator.onHeaderFilterChanged(true)),
            child: Text(I18n.of(viewService.context).inTheaters, style: state.showHeaderMovie ? _selectTextStyle : _unSelectTextStyle,),
          ),
          SizedBox(
            width: Adapt.px(30),
          ),
          InkWell(
            onTap: () => dispatch(HeaderActionCreator.onHeaderFilterChanged(false)),
            child: Text(
              I18n.of(viewService.context).onTV,
              style: state.showHeaderMovie ? _unSelectTextStyle : _selectTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderListCell(VideoListResult f) {
    String name = f.title ?? f.name;
    return Padding(
        key: ValueKey('headercell' + f.id.toString()),
        padding: EdgeInsets.only(left: Adapt.px(30)),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () =>dispatch(HomePageActionCreator.onCellTapped(
                f.id, f.backdropPath, name, f.posterPath, state.showHeaderMovie ? MediaType.movie : MediaType.tv
              )),
              child: Container(
                width: Adapt.px(200),
                height: Adapt.px(280),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(57, 57, 57, 1),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(ImageUrl.getUrl(f.posterPath, ImageSize.w300))
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            Container(
              alignment: Alignment.center,
              width: Adapt.px(200),
              height: Adapt.px(70),
              child: Text(
                name, maxLines: 2, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)),
              ),
            )
          ],
        ),
    );
  }



  return Container();
}
