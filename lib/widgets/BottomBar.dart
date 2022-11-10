import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int currentSelected;

  const BottomBar({
    Key? key,
    this.currentSelected = 0,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // List<BottomNavigationBarItem> items = [];

  int selectedIndex = 0;
  List<bool> isSelected = [true, false];

  void _onItemTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0 && ModalRoute.of(context)?.settings.name != "/") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    } else if (index == 1) {
      Navigator.of(context).pushNamed('/favorites');
    }
  }

  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    items = [
      const BottomNavigationBarItem(
        tooltip: "Home",
        backgroundColor: Colors.white,
        icon: Icon(CupertinoIcons.home),
      ),
      const BottomNavigationBarItem(
        tooltip: "Search",
        backgroundColor: Colors.white,
        icon: Icon(CupertinoIcons.search),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          label: 'Favorites',
        ),
      ],
      unselectedItemColor: Colors.grey,
      currentIndex: widget.currentSelected,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
