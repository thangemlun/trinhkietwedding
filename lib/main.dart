import 'package:flutter/material.dart';
import 'package:wedding_landing_page/landingpage/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toastification/toastification.dart';

// const firebaseConfig = {
//   apiKey: "AIzaSyDkzsnj7EEjD8Cgbrsx1SBIeMEQV0hTLA8",
//   authDomain: "trinhkietwedding.firebaseapp.com",
//   projectId: "trinhkietwedding",
//   storageBucket: "trinhkietwedding.firebasestorage.app",
//   messagingSenderId: "129931315288",
//   appId: "1:129931315288:web:9363b5094e2877de79222d",
//   measurementId: "G-H8DDHGMBXH"
// };
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDkzsnj7EEjD8Cgbrsx1SBIeMEQV0hTLA8",
      authDomain: "trinhkietwedding.firebaseapp.com",
      projectId: "trinhkietwedding",
      storageBucket: "trinhkietwedding.firebasestorage.app",
      messagingSenderId: "129931315288",
      appId: "1:129931315288:web:9363b5094e2877de79222d",
      measurementId: "G-H8DDHGMBXH"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Trinh & Kiet are getting married!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LandingPage()
      ),
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

          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
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
