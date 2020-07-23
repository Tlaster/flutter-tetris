import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:media_query_ex/media_query_ex.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/generated/i18n.dart';
import 'package:tetris/material/audios.dart';
import 'package:tetris/panel/page_portrait.dart';

import 'gamer/keyboard.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  _disableDebugPrint();
  runApp(TetrisApp());
}

void _disableDebugPrint() {
  bool debug = false;
  assert(() {
    debug = true;
    return true;
  }());
  if (!debug) {
    debugPrint = (String message, {int wrapWidth}) {
      //disable log print when not in debug mode
    };
  }
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class TetrisApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQueryExWidget(
      child: MaterialApp(
        title: 'tetris',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        navigatorObservers: [routeObserver],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body:
              Sound(child: Game(child: KeyboardController(child: _HomePage()))),
        ),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 3.0;

const BACKGROUND_COLOR = const Color(0xffefcc19);

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? PageLand() : PagePortrait();
  }
}
