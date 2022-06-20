import 'package:film_fan/models/Favorite.dart';
import 'package:film_fan/pages/detailPage.dart';
import 'package:film_fan/services/FavoriteService.dart';
import 'package:film_fan/services/MovieService.dart';
import 'package:film_fan/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String todaysDate = DateFormat().add_yMMMMEEEEd().format(DateTime.now());
  MovieServices services = new MovieServices();
  bool _isLoading = false;
  List<Favorite> favorites = [];

  @override
  void initState() {
    super.initState();
    getAllFavorites();
  }

  Future getAllFavorites() async {
    setState(() => _isLoading = true);

    favorites = await FavoritesDatabase.instance.readAllFavorites();

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorites Movies',
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      extendBody: true,
      body: Builder(builder: (context) {
        if (_isLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: NLoader(),
          );
        }

        if (favorites.isEmpty) {
          return const Center(
              child: Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                ' \t \t \t \t \t \t \t \t \t \t \t \t \t \t No Favourites \n \n(navigate to movie detail to add it to favourite)',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ));
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
      children: populateMovies(favorites),
    );
  }

  // implement populating data in the list

  List<Widget> populateMovies(List<Favorite>? favorites) {
    List<Widget> tmp = [];
    for (var movie in favorites!) {
      int movieId = int.parse(movie.movieId ?? '');
      tmp.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: GestureDetector(
              onTap: (() {
                Navigator.of(context).pushNamed(
                  DetailPage.routeName,
                  arguments: DetailPage(movieId: movieId),
                );
              }),
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${movie.poster_path}"),
                              fit: BoxFit.cover)),
                      child: Container()),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      height: 70,
                      width: 200,
                      color: Colors.black54,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2.0),
                          Text(
                            truncate(movie.title, length: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            "Release: ${movie.release_date}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            "Rate: ${movie.vote_average}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      );
    }
    return tmp;
  }

  String truncate(String? text, {length: 7, omission: '...'}) {
    if (length >= text?.length) {
      return text!;
    }
    return text!.replaceRange(length, text.length, omission);
  }
}
