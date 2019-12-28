import 'package:flutter/material.dart';
import 'package:os_movie/MyMovieWidget.dart';
import 'package:os_movie/MyNavigationWidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MyMovieWidget(),
      bottomNavigationBar: MyNavigationBarWidget(),
    );
  }
}
