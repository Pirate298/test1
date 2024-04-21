import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:test1/main.dart';
import 'package:test1/part3/drawing_canvas/drawing_canvas.dart';
import 'package:test1/part3/drawing_canvas/models/drawing_mode.dart';
import 'package:test1/part3/drawing_canvas/models/sketch.dart';
import 'package:test1/part3/drawing_canvas/widgets/canvas_side_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'drawing_canvas/models/sketch.dart';

class DrawingPage extends HookWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );

    double width = MediaQuery.of(context).size.width - 32;


    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title:const Text('Part 1'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (animationController.value == 0) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.yellow,
            margin: const EdgeInsets.all(16),
            width: width,
            height: width,
            child: DrawingCanvas(
              width: width,
              height: width,
              drawingMode: drawingMode,
              selectedColor: selectedColor,
              strokeSize: strokeSize,
              eraserSize: eraserSize,
              sideBarController: animationController,
              currentSketch: currentSketch,
              allSketches: allSketches,
              canvasGlobalKey: canvasGlobalKey,
              filled: filled,
              polygonSides: polygonSides,
              backgroundImage: backgroundImage,
            ),
          ),
          Positioned(
            top: kToolbarHeight + 10,
            // left: -5,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animationController),
              child: CanvasSideBar(
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
                backgroundImage: backgroundImage,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

