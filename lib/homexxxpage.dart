import 'package:flutter/material.dart';

class HomeXXPage extends StatefulWidget {
  @override
  _HomeXXPageState createState() => _HomeXXPageState();
}

// Our state should be mixed-in with RestorationMixin
class _HomeXXPageState extends State<HomeXXPage> with RestorationMixin {
  // For each state, we need to use a restorable property

  final RestorableInt _index = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Index is ${_index.value}')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index.value,
        onTap: (i) => setState(() => _index.value = i),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  @override
  // The restoration bucket id for this page,
  // let's give it the name of our page!
  String get restorationId => 'home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Register our property to be saved every time it changes,
    // and to be restored every time our app is killed by the OS!
    registerForRestoration(_index, 'nav_bar_index');
  }
}
