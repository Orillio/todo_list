import 'package:get_it/get_it.dart';
import 'package:todo_list/business/api/back_api.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../api/api.dart';
import '../repository/local_tasks_repository.dart';
import '../repository/remote_tasks_repository.dart';

class TodoAppServices {
  static final _getIt = GetIt.instance;

  static void registerLocalTasksRepository() {
    _getIt.registerSingleton<LocalTasksRepository>(LocalTasksRepository());
  }

  static void registerRemoteTasksRepository() {
    _getIt.registerSingleton<RemoteTasksRepository>(RemoteTasksRepository());
  }

  static void registerApi() {
    _getIt.registerSingleton<Api>(BackApi());
  }

  static void registerGoRouterController() {
    _getIt.registerSingleton<NavigationController>(NavigationController());
  }

  static void registerFirebaseAnalytics() {
    _getIt.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);
  }
}
