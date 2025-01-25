import 'package:flutter/Material.dart';
import 'package:flutter/rendering.dart';
import 'package:sos/sos_game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return SOS();
                      }),
                    );
                  },
                  child: Text('Start Game')))),
    );
  }
}
