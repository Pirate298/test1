import 'package:flutter/material.dart';
import 'package:test1/part2/animation_part2.dart';
import 'package:test1/part3/drawing_page.dart';
import 'package:test1/part1/home.dart';

const Color kCanvasColor = Color(0xffffffff);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        hintColor: Colors.purpleAccent,
        primaryColor: Colors.purple,
      ),
    );
  }

}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nguyen Van Duy_Flutter'), centerTitle:  true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [ElevatedButton(
          child: const Text(
            'Go Part 1',
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            _navigateToNextScreen(context: context, partTest: 1);
          },
        ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text(
                'Go Part 2',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                _navigateToNextScreen(context: context, partTest: 2);
              },
            )]
      ),
    );
  }

  void _navigateToNextScreen({required BuildContext context, required int partTest}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>partTest == 1 ? const DrawPart1() : AnimationPart2()));
  }
}
