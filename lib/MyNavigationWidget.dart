import 'package:flutter/material.dart';

class MyNavigationBarWidget extends StatefulWidget {
  @override
  _MyNavigationBarWidgetState createState() => _MyNavigationBarWidgetState();
}

class _MyNavigationBarWidgetState extends State<MyNavigationBarWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          print(index);
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.movie), title: Text('MOVIE')),
        BottomNavigationBarItem(icon: Icon(Icons.tv), title: Text('TV')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('ACCOUNT')),
      ],
    );
  }
}
