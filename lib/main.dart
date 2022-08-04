import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/business/server_todo_provider.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/themes/dark_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './firebase_options.dart';

void main() async {
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

      await remoteConfig.fetchAndActivate();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

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
        ChangeNotifierProvider<ITodoProvider>(
            create: (_) => ServerTodoProvider()),
        ListenableProvider(create: (_) => NavigationController()),
      ],
      child: Builder(
        builder: (context) {
          var navProvider = context.read<NavigationController>();
          return MaterialApp(
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ru'),
            ],
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorKey: navProvider.key,
            debugShowCheckedModeBanner: false,
            title: 'TodoList',
            themeMode: ThemeMode.dark,
            darkTheme: darkTheme,
            home: const TodoScreen(),
          );
        },
      ),
    );
  }
}
