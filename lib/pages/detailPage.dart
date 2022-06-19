import 'package:film_fan/models/ApiResponse.dart';
import 'package:film_fan/models/Movie.dart';
import 'package:film_fan/models/MovieDetail.dart';
import 'package:film_fan/services/MovieService.dart';
import 'package:film_fan/widgets/Loader.dart';
import 'package:flutter/material.dart';
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
  MovieServices services = new MovieServices();
  late APIResponse<MovieDetail> _apiResponse;
  late APIResponse<List<Movie>> _apiResponseSimilar;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getMovieDetail();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(
                    height: 10,
                  ),
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
        Text(
          _apiResponse.data!.title,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

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
    return const Text(
      "Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald's growing legion of followers.",
      style: TextStyle(
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
      children: populateMovies(_apiResponseSimilar.data),
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
              movieName: movie.original_title,
              voteAverage: movie.vote_average,
            ),
          ),
        ),
      );
    }
    return tmp;
  }
}
