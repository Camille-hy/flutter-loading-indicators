import 'package:flutter/material.dart';
import 'package:loading/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Indicators',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Loading Indcators'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToLoading(String choice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Loading(choice: choice),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => navigateToLoading('Shimmer'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(100, 100)),
                ),
              child: Text(
                'Shimmer',
                style: TextStyle(
                  fontSize: 25.0,
                ),
                ),
            ),
            TextButton(
              onPressed: () => navigateToLoading('Spinner'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(100, 100)),
                ),
              child: Text(
                'Spinner',
                style: TextStyle(
                  fontSize: 25.0,
                ),
                ),
            ),
            TextButton(
              onPressed: () => navigateToLoading('Progress'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(100, 100)),
                ),
              child: Text(
                'Progress',
                style: TextStyle(
                  fontSize: 25.0,
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
