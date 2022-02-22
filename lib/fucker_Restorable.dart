import 'package:flutter/material.dart';

void main() => runApp(const RestorationExampleApp());

class RestorationExampleApp extends StatelessWidget {
  const RestorationExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'app',
      title: 'Restorable Counter',
      home: RestorableCounter(restorationId: 'counter'),
    );
  }
}

class RestorableCounter extends StatefulWidget {
  const RestorableCounter({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<RestorableCounter> createState() => _RestorableCounterState();
}

class _RestorableCounterState extends State<RestorableCounter>
    with RestorationMixin {
  final RestorableInt _counter = RestorableInt(0);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'count');
  }

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restorable Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

