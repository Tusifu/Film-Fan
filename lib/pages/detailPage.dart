import 'package:film_fan/models/ApiResponse.dart';
import 'package:film_fan/models/Favorite.dart';
import 'package:film_fan/models/Movie.dart';
import 'package:film_fan/models/MovieDetail.dart';
import 'package:film_fan/services/FavoriteService.dart';
import 'package:film_fan/services/MovieService.dart';
import 'package:film_fan/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:film_fan/widgets/MovieCard.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final int movieId;
  const DetailPage({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String todaysDate = DateFormat().add_yMMMMEEEEd().format(DateTime.now());
  MovieServices services = MovieServices();
  late APIResponse<MovieDetail> _apiResponse;
  late APIResponse<List<Movie>> _apiResponseSimilar;
  List<Favorite> favorites = [];
  bool _isLoading = false;
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    getMovieDetail();
    getAllFavorites();
  }

  getMovieDetail() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await services.getMovieDetail(widget.movieId);
    _apiResponseSimilar = await services.getSimilar(widget.movieId);
    setState(() {
      _isLoading = false;
    });
  }

  Future getAllFavorites() async {
    // setState(() => isLoading = true);
    // var res = await FavoritesDatabase.instance.deleteTable();
    // print(res);
    favorites = await FavoritesDatabase.instance.readAllFavorites();
    print(favorites[0].movieId);

    var infav = _inFavorites(widget.movieId.toString());
    print(infav);

    // setState(() => isLoading = false);
  }

  Icon _buildFavorites(List<dynamic> favorites, String movieId) {
    if (!_inFavorites(movieId)) {
      return const Icon(
        Icons.favorite_border,
        color: Colors.white,
      );
    } else {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
  }

  bool _inFavorites(String movieId) {
    List inFav = [];
    if (favorites != null) {
      for (int i = 0; i < favorites.length; i++) {
        // ignore: unrelated_type_equality_checks
        if (favorites[i].movieId == movieId) {
          inFav.add(favorites[i]);
        }
      }
    } else {
      print('favs are null');
    }
    return inFav.length > 0 ? true : false;
  }

  Widget FavoriteIcon() {
    //*******  SHOW FAVORITE ICON ********* */

    return FutureBuilder(
      future:
          FavoritesDatabase.instance.findByDbMovieId(widget.movieId.toString()),
      builder: (context, snapshot) {
        Color iconColor = Colors.white;
        IconData iconShape = Icons.favorite_border;
        if (snapshot.hasData != null) {
          iconColor = Colors.red;
          iconShape = Icons.favorite;
        }
        return IconButton(
          color: iconColor,
          icon: Icon(iconShape),
          iconSize: 25,
          onPressed: () async {
            if (snapshot.hasData != null) {
              // implement delete
              final result = await FavoritesDatabase.instance
                  .delete(widget.movieId.toString());
              if (result == 1) {
                const message = 'Favorite Removed Successfully';
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(message),
                  ),
                );
                setState(() {});
              } else {
                const message = 'An error while removing favorite';
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(message),
                  ),
                );
              }
            } else {
              // implement add
              await addFavorite(
                widget.movieId.toString(),
                _apiResponse.data?.vote_average.toString(),
                _apiResponse.data?.poster_path,
                _apiResponse.data?.release_date,
                _apiResponse.data?.title,
              );
              setState(() {});
              const message = 'Favorite Added Successfully';

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(message),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<int> addFavorite(String? movieId, String? vote_average,
      String? poster_path, String? release_date, String? title) async {
    final favorite = Favorite(
      title: title,
      vote_average: vote_average,
      poster_path: poster_path,
      movieId: movieId,
      release_date: release_date,
    );
    final result = await FavoritesDatabase.instance.create(favorite);
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'FILM FAN',
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          //*******  SHOW FAVORITE ICON ********* */
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 5.0),
            child: GestureDetector(
              onTap: () async {
                //check if for each data if its uuid
                // is in list of SQL db favorited
                //(uuid field).
                if (!_inFavorites(widget.movieId.toString())) {
                  await addFavorite(
                    widget.movieId.toString(),
                    _apiResponse.data?.vote_average.toString(),
                    _apiResponse.data?.poster_path,
                    _apiResponse.data?.release_date,
                    _apiResponse.data?.title,
                  );
                  ;

                  getAllFavorites();

                  setState(() {});
                  const message = 'Favorite Added Successfully';

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(message),
                    ),
                  );
                } else {
                  final result = await FavoritesDatabase.instance
                      .delete(widget.movieId.toString());

                  print(result);
                  if (result == 1) {
                    setState(() {});
                    const message = 'Favorite Removed Successfully';

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(message),
                      ),
                    );
                    getAllFavorites();
                  } else {
                    const message = 'An error while removing favorite';

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(message),
                      ),
                    );
                  }
                }
              },
              child: _buildFavorites(favorites, widget.movieId.toString()),
            ),
          )
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildMoviePoster(),
                  const SizedBox(
                    height: 20,
                  ),
                  _detailTitle(),
                  const SizedBox(
                    height: 10,
                  ),
                  _versionReleaseSection(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Rate This Movie:",
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      buildRating(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _detailBody(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Genres",
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 0.3,
                    color: Colors.grey,
                  ),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _apiResponse.data!.genres.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 0.3,
                      color: Colors.grey,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 1.0,
                          right: 0.0,
                        ),
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(
                          _apiResponse.data!.genres[index].name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 0.3,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Similar Movies",
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildGrid(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Row _detailTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            _apiResponse.data!.title,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRating() => RatingBar.builder(
        unratedColor: Colors.grey,
        initialRating: rating,
        minRating: 1,
        itemSize: MediaQuery.of(context).size.height * 0.03,
        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) async {
          setState(
            () {
              print(rating);
              this.rating = rating;
            },
          );

          // call rate movie service to rate movie, pass the movie id and rating value
          var res = await services.rateMovie(widget.movieId, rating);
          print(res.error);
        },
      );

  Row _versionReleaseSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Release Year: ${_apiResponse.data!.release_date.split("-")[0]}",
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Rating: ${_apiResponse.data!.vote_average.toString()}",
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Text _detailBody() {
    return Text(
      _apiResponse.data!.overview,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 13,
      ),
      textAlign: TextAlign.justify,
    );
  }

  StaggeredGrid buildMoviePoster() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500/${_apiResponse.data!.poster_path}"),
                    fit: BoxFit.cover),
              ),
              child: Container()),
        )
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: populateMovies(_apiResponseSimilar.data).isEmpty
          ? [
              Text(
                "No Similar Movies for ${_apiResponse.data!.title}",
                style: const TextStyle(color: Colors.white, fontSize: 10),
              )
            ]
          : populateMovies(_apiResponseSimilar.data),
    );
  }

  // implement populating data in the list

  List<Widget> populateMovies(List<Movie>? movies) {
    List<Widget> tmp = [];
    var mv = movies;
    if (mv != null) {
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
                movieName: movie.original_title,
                voteAverage: movie.vote_average,
              ),
            ),
          ),
        );
      }
    }

    return tmp;
  }
}
