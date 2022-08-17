import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/di/todo_app_services.dart';
import 'package:todo_list/business/provider_models.dart/tasks_provider.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/themes/dark_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/todo_model.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      var remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 5),
      ));

      remoteConfig.setDefaults(
          {"importanceColor": ConstDarkColors.colorRed.value.toString()});
      try {
        await remoteConfig.fetchAndActivate();
      } catch (e) {
        Logger().e("Couldn't fecth remote configs");
      }
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      await Hive.initFlutter();
      Hive.registerAdapter(TodoModelAdapter());
      await Hive.openBox<TodoModel>("todoBox");
      await Hive.openBox<int>("revision");

      TodoAppServices.registerApi();
      TodoAppServices.registerLocalTasksRepository();
      TodoAppServices.registerRemoteTasksRepository();
      TodoAppServices.registerNavigationController();

      runApp(const MyApp());
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Wrapping MaterialApp in MultiProvider to access models in all routes.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
      ],
      child: MaterialApp(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: GetIt.I<NavigationController>().key,
        debugShowCheckedModeBanner: false,
        title: 'TodoList',
        themeMode: ThemeMode.system,
        darkTheme: darkTheme,
        theme: lightTheme,
        home: const TodoScreen(),
      ),
    );
  }
}
