import 'package:film_fan/models/ApiResponse.dart';
import 'package:film_fan/models/Movie.dart';
import 'package:film_fan/pages/detailPage.dart';
import 'package:film_fan/services/MovieService.dart';
import 'package:film_fan/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'FILM FAN',
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_sharp),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      extendBody: true,
      body: Builder(builder: (context) {
        if (_isLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: NLoader(),
          );
        }

        if (_apiResponse.error) {
          return const Center(
            child: Text('An error occured'),
          );
        }
        return _buildBody();
      }),
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
                  buildGrid(),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: populateMovies(_apiResponse.data),
    );
  }

  // implement populating data in the list

  List<Widget> populateMovies(List<Movie>? movies) {
    List<Widget> tmp = [];
    for (var movie in movies!) {
      tmp.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: GestureDetector(
            onTap: (() {
              Navigator.of(context).pushNamed(
                DetailPage.routeName,
                arguments: DetailPage(movieId: movie.id),
              );
            }),
            child: MovieCard(
              poster: movie.poster_path,
              isSmall: true,
              movieRelease: movie.release_date,
              movieName: movie.title,
              voteAverage: movie.vote_average,
            ),
          ),
        ),
      );
    }
    return tmp;
  }
}
