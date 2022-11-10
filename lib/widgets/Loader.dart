import 'package:flutter/material.dart';

class NLoader extends StatefulWidget {
  @override
  _NLoaderState createState() => _NLoaderState();
}

class _NLoaderState extends State<NLoader> with SingleTickerProviderStateMixin {
  late AnimationController _fadeTransition;
  late Animation opacityAnimation;

  listener() {
    if (_fadeTransition.isCompleted) {
      _fadeTransition.reverse();
    } else if (_fadeTransition.isDismissed) {
      _fadeTransition.forward();
    }
  }

  @override
  void dispose() {
    _fadeTransition.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _fadeTransition = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    opacityAnimation = Tween<double>(begin: 0.2, end: 1).animate(
        CurvedAnimation(parent: _fadeTransition, curve: Curves.bounceIn));
    _fadeTransition.forward();
    _fadeTransition.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 35,
        width: 35,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  List<Widget> makePlaceHolderServices() {
    List<Widget> tmp = [];

    Container placeholderService = Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(15),
//        border: Border.all(color: Colors.grey)
      ),
    );

    for (int x = 0; x < 3; x++) {
      tmp.add(placeholderService);
    }
    return tmp;
  }
}
