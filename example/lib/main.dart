import 'package:flutter/material.dart';
import 'package:t_stack/t_stack.dart';

void main() {
  TStack.init(routeMap);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => TStackApp();
}

final routeMap = <String, TRouteBuilder>{
  'flutterPage1': (TNode node) {
    return page1Builder;
  },
  'flutterPage2': (TNode node) {
    return page2Builder;
  }
};

final WidgetBuilder page1Builder = (BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('FlutterPage1'),
    ),
    body: Center(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('push(nativePage1)'),
            onPressed: () {
              TStack.push('nativePage1');
            },
          )
        ],
      ),
    ),
  );
};

final WidgetBuilder page2Builder = (BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('FlutterPage2'),
    ),
    body: Center(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('push(nativePage1)'),
            onPressed: () {
              TStack.push('nativePage1');
            },
          )
        ],
      ),
    ),
  );
};
