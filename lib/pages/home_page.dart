import 'package:flutter/material.dart';
import '../widgets/animations.dart';
import '../widgets/image_animation.dart';
import 'auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> _images = [
    'assets/images/beautyproductsnew.webp',
    'assets/images/beautyproducts.jpg',
    'assets/images/foodproducts.jpg',
    'assets/images/itproducts.jpg',
    'assets/images/laptop.jpg',
    'assets/images/moblies.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = Animations.createAnimationController(this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 166, 176, 181)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: isPortrait
                ? _buildPortraitLayout()
                : _buildLandscapeLayout(),
          ),
        ),
      ),
    );
  }

  // Portrait Layout
  Widget _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(), 
        const Text(
          'Product Navigator',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 20),
        Flexible(
          flex: 2, 
          child: ImageAnimation(images: _images, controller: _controller),
        ),
        const SizedBox(height: 20),
        _buildAuthButtons(),
        const Spacer(),
      ],
    );
  }

  // Landscape 
  Widget _buildLandscapeLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4, 
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ImageAnimation(images: _images, controller: _controller),
          ),
        ),
        Expanded(
          flex: 2, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Product Navigator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              _buildAuthButtons(),
            ],
          ),
        ),
      ],
    );
  }

  // Buttons
  Widget _buildAuthButtons() {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 200, 
            child: ElevatedButton(
              onPressed: () {
                _navigateToPage(const AuthPage(isLogin: true));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[500],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            width: 200, 
            child: ElevatedButton(
              onPressed: () {
                _navigateToPage(const AuthPage(isLogin: false));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[700],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


