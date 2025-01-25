import 'package:sos/HomeScreen.dart';
import 'package:flutter/Material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'SOS game',
      home:HomeScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}
