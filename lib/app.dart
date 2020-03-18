import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:common_utils/common_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movie/generated/i18n.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/main_page/page.dart';

import 'actions/timeline.dart';

Future _init() async {
  if (Platform.isAndroid) {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }
  setLocaleInfo('zh', TimelineInfoCN());
  setLocaleInfo('en', TimelineInfoEN());
  setLocaleInfo('Ja', TimelineInfoJA());
}

Future<Widget> createApp() async {
  final AbstractRoutes routes = PageRoutes(
      pages: <String, Page<Object, dynamic>> {
        'mainpage': MainPagePage()
      },
      visitor: (String path, Page<Object, dynamic> page) {
        if (page.isTypeof<GlobalBaseState>()) {
          page.connectExtraStore<GlobalState>(GlobalStore.store,
                  (Object pagestate, GlobalState appState) {
            final GlobalBaseState p = pagestate;
            if (p.themeColor != appState.themeColor ||
                p.locale != appState.locale ||
                p.user != appState.user) {
              if (pagestate is Cloneable) {
                final Object copy = pagestate.clone();
                final GlobalBaseState newState = copy;
                newState.themeColor = appState.themeColor;
                newState.locale = appState.locale;
                newState.user = appState.user;
                return newState;
              }
            }
            return pagestate;
          });
        }
        page.enhancer.append(
          /// View AOP
          viewMiddleware: <ViewMiddleware<dynamic>>[
            safetyView<dynamic>(),
          ],

          /// Adapter AOP
          adapterMiddleware: <AdapterMiddleware<dynamic>>[
            safetyAdapter<dynamic>()
          ],

          /// Effect AOP
          effectMiddleware: [
            _pageAnalyticsMiddleware<dynamic>(),
          ],

          /// Store AOP
          middleware: <Middleware<dynamic>>[
            logMiddleware<dynamic>(tag: page.runtimeType.toString()),
          ],
        );
      },
  );

  final ThemeData _lightTheme = ThemeData.light();
  final ThemeData _darkTheme = ThemeData.dark();
  await _init();

  return MaterialApp(
    title: 'Movie',
    debugShowCheckedModeBanner: false,
    theme: _lightTheme,
    darkTheme: _darkTheme,
    localizationsDelegates: [
      I18n.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: I18n.delegate.supportedLocales,
    localeResolutionCallback:
      I18n.delegate.resolution(fallback: new Locale("en", "US")),
    home: routes.buildPage('mainpage', {
      'pages': List<Widget>.unmodifiable([
        //routes.buildPage('homePage', null),
      ])
    }),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}


EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}