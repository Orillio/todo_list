import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/fake_todo_provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/themes/dark_theme.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Wrapping MaterialApp in MultiProvider to access models in all routes.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ITodoProvider>(create: (_) => FakeTodoProvider()),
        Provider(create: (_) => NavigationController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TodoList',
        themeMode: ThemeMode.dark,
        darkTheme: darkTheme,
        home: const TodoScreen(),
      ),
    );
  }
}
