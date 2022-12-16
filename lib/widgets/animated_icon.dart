import 'package:flutter/material.dart';

///  Created by mac on 16/12/22.
class AnimatedIcon extends StatefulWidget {
  final Widget iconWidget;
  const AnimatedIcon({super.key, required this.iconWidget});

  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  double scale = 0.0;

  @override
  void initState() {
    super.initState();
    const quick = Duration(milliseconds: 500);
    final scaleTween = Tween(begin: 0.0, end: 1.0);
    controller = AnimationController(duration: quick, vsync: this);
    animation = scaleTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() => scale = animation.value);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _animate() {
    animation.addStatusListener((AnimationStatus status) {
      if (scale == 1.0) {
        controller.reverse();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.scale(
        scale: scale,
        child: widget.iconWidget,
      ),
    );
  }
}
