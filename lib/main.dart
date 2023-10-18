import 'package:flutter/material.dart';
import 'package:appsonair_flutter_sdk/apps_on_air_service.dart';

void main() {
  AppsOnAir.setAppId('6d7dbcfc-5c88-4164-aa60-0860c13b3982',
      showNativeUI: false);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  initState() {
    super.initState();

    AppsOnAir.checkForAppUpdate(context, customWidget: (response) {
      bool isUpdate = response["updateData"]["isAndroidUpdate"];
      print(isUpdate);

      return AlertDialog(
        title: Text('New Update Available'),
        content: Text(
            'A new version of the app is available. Do you want to update now?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Perform actions if the user chooses not to update
            },
            child: Text('Not Now'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Perform actions to initiate the update process
            },
            child: Text('Update'),
          ),
        ],
      );
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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
