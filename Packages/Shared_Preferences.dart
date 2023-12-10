import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static const String appTitle = 'Shared Preferences';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          centerTitle: true,
        ),
        body: const MySharedPreferences(),
      ),
    );
  }
}

class MySharedPreferences extends StatefulWidget {
  const MySharedPreferences({super.key});

  @override
  State<MySharedPreferences> createState() => _MySharedPreferencesState();
}

class _MySharedPreferencesState extends State<MySharedPreferences> {
  // Set initial value of counter
  int _counter = 0;
  String _name = 'Counter Value';

  @override
  void initState() {
    super.initState();
    // Load counter when app starts
    _loadCounter();
  }

// Load counter
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      _name = prefs.getString('name') ?? 'Asif';
    });
  }

// Increment counter
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _counter + 1;
      _name = 'Value Incremented';
      prefs.setInt('counter', _counter);
      prefs.setString('name', _name);
    });
  }

  // Decrement counter
  Future<void> _decrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _counter - 1;
      _name = 'Value Decremented';
      prefs.setInt('counter', _counter);
      prefs.setString('name', _name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Counter: $_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: _incrementCounter,
                label: const Text(
                  'Add',
                  style: TextStyle(fontSize: 24),
                )),
            ElevatedButton.icon(
                icon: const Icon(Icons.remove),
                onPressed: _decrementCounter,
                label: const Text(
                  'Subtract',
                  style: TextStyle(fontSize: 24),
                )),
          ]),
        ],
      ),
    );
  }
}
