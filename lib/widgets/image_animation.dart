import 'package:flutter/material.dart';

class ImageAnimation extends StatefulWidget {
  final List<String> images;
  final AnimationController controller;

  const ImageAnimation({
    super.key,
    required this.images,
    required this.controller,
  });

  @override
  State<ImageAnimation> createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: Stack(
        children: widget.images.asMap().entries.map((entry) {
          int index = entry.key;
          String image = entry.value;
          double start = index / widget.images.length;
          double end = (index + 1) / widget.images.length;

          return AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              double scale = 0.0;
              double opacity = 1.0;

              if (widget.controller.value >= start && widget.controller.value <= end) {
                double t = (widget.controller.value - start) / (end - start);
                scale = 0.5 + 0.5 * t;
                opacity = 1.0 - t;
              }

              return Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}