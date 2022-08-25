import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/models/todo_model_domain.dart';
import 'package:todo_list/navigation/animations/sliding_backward_page.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/screens/update_todo_screen.dart';

import 'animations/scale_page.dart';

class ApplicationConfiguration {
  final bool _isTodoList;
  TodoModelDomain? _todoModel;

  bool get isTodoList => _isTodoList;
  bool get isCreatePage => !_isTodoList && _todoModel == null;
  bool get isTodoPage => !_isTodoList && _todoModel != null;

  ApplicationConfiguration(this._isTodoList, this._todoModel);

  ApplicationConfiguration.todoList() : _isTodoList = true;
  ApplicationConfiguration.create() : _isTodoList = false;
  ApplicationConfiguration.page(TodoModelDomain model)
      : _isTodoList = false,
        _todoModel = model;
}

class TodoRouterInformationParser
    extends RouteInformationParser<ApplicationConfiguration> {
  @override
  Future<ApplicationConfiguration> parseRouteInformation(
      RouteInformation routeInformation) {
    if (routeInformation.location == null) {
      return SynchronousFuture(ApplicationConfiguration.todoList());
    }
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(ApplicationConfiguration.todoList());
    }
    switch (uri.pathSegments[0]) {
      case "create":
        return SynchronousFuture(ApplicationConfiguration.create());
      default:
        return SynchronousFuture(
          ApplicationConfiguration.todoList(),
        );
    }
  }

  @override
  RouteInformation? restoreRouteInformation(
      ApplicationConfiguration configuration) {
    if (configuration.isTodoList) {
      return const RouteInformation(location: "/");
    }
    if (configuration.isCreatePage) {
      return const RouteInformation(location: "/create");
    }
    if (configuration.isTodoPage) {
      return RouteInformation(
        location: "/${configuration._todoModel?.id ?? ""}",
        state: configuration._todoModel as Object,
      );
    }
    return const RouteInformation(location: "/");
  }
}

class TodoRouterDelegate extends RouterDelegate<ApplicationConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<ApplicationConfiguration> {
  bool _isTodoList;
  TodoModelDomain? _todoModel;

  TodoRouterDelegate(this._isTodoList, this._todoModel);

  bool get isTodoList => _isTodoList;
  bool get isCreatePage => !_isTodoList && _todoModel == null;
  bool get isTodoPage => !_isTodoList && _todoModel != null;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  List<Page> get _pages => [
        const ScalePage(
          key: ValueKey("1"),
          child: TodoScreen(),
        ),
        if (isCreatePage)
          const SlidingForwardPage(
            key: ValueKey("2"),
            child: UpdateTodoScreen(),
          ),
        if (isTodoPage)
          SlidingForwardPage(
            key: const ValueKey("3"),
            child: UpdateTodoScreen(
              model: _todoModel!,
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [
        HeroController(),
        FirebaseAnalyticsObserver(analytics: GetIt.I<FirebaseAnalytics>())
      ],
      onPopPage: (route, result) {
        return route.didPop(result);
      },
      pages: _pages,
    );
  }

  @override
  ApplicationConfiguration? get currentConfiguration =>
      ApplicationConfiguration(_isTodoList, _todoModel);

  @override
  Future<void> setNewRoutePath(ApplicationConfiguration configuration) {
    _isTodoList = configuration._isTodoList;
    _todoModel = configuration._todoModel;
    return Future.value();
  }

  void gotoUpdateTodoScreen(TodoModelDomain parameter) {
    _isTodoList = false;
    _todoModel = parameter;
    notifyListeners();
  }

  void gotoCreateTodoScreen() {
    _isTodoList = false;
    _todoModel = null;
    notifyListeners();
  }

  void gotoTodoList() async {
    await popRoute();
    _isTodoList = true;
    _todoModel = null;
    notifyListeners();
  }
}

class NavigationController {
  late final TodoRouterDelegate delegate;
  late final TodoRouterInformationParser parser;

  NavigationController() {
    delegate = TodoRouterDelegate(true, null);
    parser = TodoRouterInformationParser();
  }

  void gotoUpdateTodoScreen(TodoModelDomain parameter) =>
      delegate.gotoUpdateTodoScreen(parameter);

  void gotoCreateTodoScreen() => delegate.gotoCreateTodoScreen();

  void gotoTodoList() => delegate.gotoTodoList();
}
