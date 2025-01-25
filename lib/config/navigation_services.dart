import 'dart:async';
import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<T?> nextScreen<T extends Object?>(Widget screen,
    [BuildContext? context]) async {
  return await Navigator.of(context ?? navigatorKey.currentContext!)
      .push<T>(CupertinoPageRoute(builder: (context) => screen));
}

Future<void> nextReplace(Widget screen, [BuildContext? context]) async {
  await Navigator.of(context ?? navigatorKey.currentContext!)
      .pushReplacement(CupertinoPageRoute(builder: (context) => screen));
}

Future<void> nextRemoveUntil(Widget screen, [BuildContext? context]) async {
  await Navigator.of(context ?? navigatorKey.currentContext!)
      .pushAndRemoveUntil(
    CupertinoPageRoute(builder: (c) => screen),
    (v) => false,
  );
}

void backScreen([dynamic result]) {
  navigatorKey.currentState!.pop(result);
}

void goBackUntil() {
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
