import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'animated_screen.dart';

class AnimationPart2 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AnimationPart2> with TickerProviderStateMixin {
  late Animation  _heartAnimation;
  late Animation<Offset> _arrowAnimation;
  late AnimationController _arrowAnimationController, _heartAnimationController;

  GlobalKey keyHeart = GlobalKey();

  GlobalKey keyHeart1 = GlobalKey();
  GlobalKey keyHeart2 = GlobalKey();
  GlobalKey keyHeart3 = GlobalKey();


  var heartOffset = const Offset(0, 0);
  var heartSize = const Size(10, 10);

   double bigHeart = 80;
   double smallHeart = 50;



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => getPositionHeartAll());




    _heartAnimationController = AnimationController(
        vsync: this, duration:const Duration(milliseconds: 1200));
    _heartAnimation = Tween(begin: 50.0, end: 80.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));

    _arrowAnimationController =
        AnimationController(vsync: this, duration:const Duration(milliseconds: 2000));
    _arrowAnimation = Tween<Offset>(begin:  Offset.zero, end: heartOffset).animate(CurvedAnimation(
      parent: _arrowAnimationController,
      curve: Curves.elasticIn,
    ));




    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
         _arrowAnimationController.forward();
      }
    });

    _arrowAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _arrowAnimationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Part 2'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Container(
           width: double.infinity,
             height: 150,
             child:  secondChild(sizeScreen)),
          SizedBox(
            height: 50.0,
          ),
          iconHeartAll(),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            child: Text('Start Beating Heart Animation'),
            onPressed: () {
              _heartAnimationController.forward();
            },
          ),
        ],
      ),
      )
      ;
  }



  Widget secondChild(Size screenSize) {
    return Stack(children: [Container(
      color: Colors.blue,
      width: double.infinity,
      height: 150,
    ),
      iconHeart(keyHeart1, screenSize)
      // Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // children: <Widget>[
      //   iconHeart(keyHeart1, screenSize),
      //   iconHeart(keyHeart2, screenSize),
      //   iconHeart(keyHeart3, screenSize)
    //   ]
    // )
    ]);
  }

  Widget iconHeart(GlobalKey key, Size screenSize) {

    return AnimatedBuilder(
      animation:Listenable.merge(
          [_heartAnimationController, _arrowAnimationController]),
      builder: (context, child) {
        return Stack(children: [PositionedTransition(
            rect: RelativeRectTween(
                begin:
                RelativeRect.fromSize(Rect.fromLTWH(screenSize.width/5 - bigHeart /2, 0, bigHeart, bigHeart),
                    screenSize),
                end:  RelativeRect.fromSize(Rect.fromLTWH(heartOffset.dx + smallHeart ,heartOffset.dy + smallHeart, smallHeart, smallHeart),
                    screenSize)
            ).animate(CurvedAnimation(parent: _arrowAnimationController, curve: Curves.easeInOutQuart)),
            child: Icon(
              key: key,
              Icons.favorite,
              color: Colors.yellow,
              size: _heartAnimation.value,
            ))]) ;
      },
    );
  }

  void getPositionHeartAll() {
    RenderBox box = keyHeart.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    heartOffset = position;
    heartSize = box.size;

  }







  Widget iconHeartMove() {
    return AnimatedPositioned(
      width: heartSize.width,
      height: heartSize.height,
      top: 0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: () {
          setState(() {

          });
        },
        child: const ColoredBox(
          color: Colors.blue,
          child: Center(child: Text('Tap me')),
        ),
      ),
    );
  }

  Widget iconHeartAll() {
    return Container(
        height: 30,
        width: 30,
        key: keyHeart,
        child:Icon(
          Icons.favorite,
          color: Colors.blue,
          size: _heartAnimation.value,
        ));
  }

}
