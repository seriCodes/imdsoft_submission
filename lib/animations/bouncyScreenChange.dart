import 'package:flutter/material.dart';

class BouncyScreenChange extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings routeSettings;

  BouncyScreenChange({this.widget, this.routeSettings})
      : super(
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child,
          ) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.bottomRight);
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return widget;
          },
          settings: routeSettings,
        );
}
