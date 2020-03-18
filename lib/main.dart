import 'package:flutter/material.dart';

void main() => runApp(MyApp());
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      navigatorObservers: [MyRouteObserver()],
      home: Screen1(),
      routes: {
        'screen2': (context) => Screen2(),
        'screen3': (context) => Screen3(),
      },
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Screen 1'),
            SizedBox(height: 30.0),
            RaisedButton(
              child: Text('Screen 2'),
              onPressed: () => Navigator.of(context).pushNamed('screen2'),
            ),
            RaisedButton(
              child: Text('Screen 3'),
              onPressed: () => Navigator.of(context).pushNamed('screen3'),
            )
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text('Screen 2')));
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text('Screen 3')));
  }
}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final Widget child;

  MyRouteObserver({this.child});

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    print('screenName $screenName');
    Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(), body: Center(child: Text('Screen 5')));
    }
    
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}