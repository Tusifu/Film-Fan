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

    print(_apiResponse);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          todaysDate,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: CircleGradientIcon(
        //       onTap: () {
        //         Navigator.pushNamed(context, Routes.todaysTask);
        //       },
        //       icon: Icons.calendar_month,
        //       color: Colors.purple,
        //       iconSize: 24,
        //       size: 40,
        //     ),
        //   )
        // ],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.menu_rounded,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
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
        )
        //   Positioned(
        //     bottom: 30,
        //     // left: 100.w / 2 - (70 / 2),
        //     right: 30,
        //     child: CircleGradientIcon(
        //       color: Colors.blue,
        //       onTap: () {},
        //       size: 60,
        //       iconSize: 30,
        //       icon: Icons.add,
        //     ),
        //   )
      ],
    );
  }

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "On Going",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Text(
            "See all",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
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
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.add_circle_outline,
        //       color: Colors.blue[400],
        //     ))
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
            color: Colors.green,
            isSmall: true,
            icon: Icons.track_changes,
            taskCount: "120,000 RWF",
            taskGroup: "Intego",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.outbond_outlined,
            taskCount: "70,000 RWF",
            taskGroup: "Ayishyuwe",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.commit,
            taskCount: "65,000 RWF",
            taskGroup: "Ari Munzira",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.today,
            taskCount: "18,000 RWF",
            taskGroup: "Ayuyu Munsi",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.date_range,
            taskCount: "20,000 RWF",
            taskGroup: "Ayukwezi",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.orange,
            isSmall: true,
            icon: Icons.house_outlined,
            taskCount: "Ingo 25",
            taskGroup: "Ingo zose",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.other_houses_outlined,
            taskCount: "Ingo 12",
            taskGroup: "Ingo zishyura neza",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: MovieCard(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.hide_source_sharp,
            taskCount: "Ingo 13",
            taskGroup: "Ingo zishura nabi",
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
