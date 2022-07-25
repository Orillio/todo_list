import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  final GlobalKey<NavigatorState> _key = GlobalKey();
  GlobalKey<NavigatorState> get key => _key;

  //Todo: push, pop routes
}
