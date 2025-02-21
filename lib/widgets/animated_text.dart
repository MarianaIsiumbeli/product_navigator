// import 'package:flutter/material.dart';

// class AnimatedText extends StatefulWidget {
//   final String text;
//   final TextStyle style;

//   const AnimatedText({required this.text, required this.style});

//   @override
//   _AnimatedTextState createState() => _AnimatedTextState();
// }

// class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late List<String> _characters;

//   @override
//   void initState() {
//     super.initState();

//     _characters = widget.text.split('');

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..repeat(reverse: false);

//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String visibleText = '';
//     int visibleLength = (_animation.value * _characters.length).toInt();

//     for (int i = 0; i < visibleLength; i++) {
//       visibleText += _characters[i];
//     }

//     return Text(
//       visibleText,
//       style: widget.style,
//     );
//   }
// }