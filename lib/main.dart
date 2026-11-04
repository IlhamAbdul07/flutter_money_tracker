import 'package:flutter/material.dart';
import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseHelper.instance.database;
  runApp(const MyApp());
  final tables = await db.rawQuery(
    "SELECT name FROM sqlite_master WHERE type = 'table'",
  );
  debugPrint(" hali $tables");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeScreen(),
    );
  }
}
