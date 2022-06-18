import 'package:film_fan/models/ApiResponse.dart';
import 'package:film_fan/models/Movie.dart';
import 'package:film_fan/services/MovieService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:film_fan/core/res/color.dart';
import 'package:film_fan/widgets/MovieCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String todaysDate = DateFormat().add_yMMMMEEEEd().format(DateTime.now());
  MovieServices services = new MovieServices();
  late APIResponse<List<Movie>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getPlayingMovies();
  }

  getPlayingMovies() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await services.getPlayingMovies();

    // print(_apiResponse);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _taskHeader(),
                  const SizedBox(
                    height: 15,
                  ),
                  buildGrid(),
                  const SizedBox(
                    height: 25,
                  ),
                  // _onGoingHeader(),
                  const SizedBox(
                    height: 10,
                  ),
                  // const OnGoingTask(),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Row _taskHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Film Fan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: const [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-04-06",
            movieName: "Fantastic Beasts",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/neMZH82Stu91d3iqvLdNQfqPPyl.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-03-24",
            movieName: "The Lost City",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/6JjfSchsU6daXk2AKX8EEBjO3Fm.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-04-06",
            movieName: "Morbius",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/8Kce1utfytAG5m1PbtVoDzmDZJH.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-06-23",
            movieName: "A Day to Die",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/QaNLpq3Wuu2yp5ESsXYcQCOpUk.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-04-28",
            movieName: "Memory",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/zhLKlUaF1SEpO58ppHIAyENkwgw.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-04-28",
            movieName: "The Northman",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            poster: '/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg',
            color: Colors.blueGrey,
            isSmall: true,
            movieRelease: "2022-04-28",
            movieName: "Jurassic World",
          ),
        ),
      ],
    );
  }
}

class OnGoingTask extends StatelessWidget {
  const OnGoingTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Startup Website Design with Responsive",
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.purple[300],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "10:00 AM - 12:30PM",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Complete - 80%",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Icon(
            Icons.rocket_rounded,
            size: 60,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    final firstControlPoint = Offset(size.width * 0.6, 0);
    final firstEndPoint = Offset(size.width * 0.58, 44);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secControlPoint = Offset(size.width * 0.55, 50);
    final secEndPoint = Offset(size.width * 0.5, 50);
    path.quadraticBezierTo(
      secControlPoint.dx,
      secControlPoint.dy,
      secEndPoint.dx,
      secEndPoint.dy,
    );

//     path.lineTo(size.width * 0.45, 30);

//     final lastControlPoint = Offset(size.width * 0.45, 20);
//     final lastEndPoint = Offset(size.width * 0.2, 30);
//     path.quadraticBezierTo(
//       lastControlPoint.dx,
//       lastControlPoint.dy,
//       lastEndPoint.dx,
//       lastEndPoint.dy,
//     );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
