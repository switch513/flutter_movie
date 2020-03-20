import 'package:fish_redux/fish_redux.dart';

import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
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
                }),
            middleware: <Middleware<HomePageState>>[
            ],);

  @override
  CustomstfState<HomePageState> createState()  => CustomstfState<HomePageState>();


}
