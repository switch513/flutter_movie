import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/home_page/components/share_component/component.dart';
import 'package:movie/views/home_page/components/share_component/state.dart';
import 'package:movie/views/home_page/components/trending_component/component.dart';
import 'package:movie/views/home_page/components/trending_component/state.dart';

import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/swiper_component/component.dart';
import 'components/swiper_component/state.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomePageState, Map<String, dynamic>> {

  HomePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomePageState>(
                adapter: null,
                slots: <String, Dependent<HomePageState>>{
                  'header': HeaderConnector() + HeaderComponent(),
                  'swiper': SwiperConnection() + SwiperComponent(),
                  'trending': TrendingConnector() + TrendingComponent(),
                  'share': ShareConnectior() + ShareComponent(),
                }),
            middleware: <Middleware<HomePageState>>[
            ],);

  @override
  CustomstfState<HomePageState> createState()  => CustomstfState<HomePageState>();


}
