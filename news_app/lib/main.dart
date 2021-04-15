import 'package:flutter/material.dart';
import './screens/overview_screen.dart';
import 'package:provider/provider.dart';
import './providers/news_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsProvider>(
      create: (ctx) => NewsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.redAccent,
        ),
        home: OverviewScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

