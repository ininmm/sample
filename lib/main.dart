import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/SecondPage.dart';
import 'package:sample/loading_dialog.dart';
import 'package:sample/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: getGlobalRouter(MyHomePage.routePath),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const String routePath = '/routeHome';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToSecondPage(BuildContext context) async {
    context.push(LoadingDialog.routePath);
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) {
      return;
    }
    context.pop();
    context.push(SecondPage.routePath);
  }

  void _navigateToSecondPageWithParam(BuildContext context) async {
    context.push(LoadingDialog.routePathWithParam, extra: 'some data');
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) {
      return;
    }
    context.pop();
    context.push(SecondPage.routePath);
  }

  @override
  void initState() {
    super.initState();
    log('FirstPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 48,
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToSecondPage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                child: const Text(
                  'navigate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 48,
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToSecondPageWithParam(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                child: const Text(
                  'navigateWithParam',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
