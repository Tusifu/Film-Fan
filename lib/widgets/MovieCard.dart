import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final bool? isSmall;
  final String movieName;
  final String movieRelease;
  final String poster;
  final num voteAverage;
  const MovieCard(
      {Key? key,
      this.isSmall = false,
      required this.movieName,
      required this.movieRelease,
      required this.poster,
      required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image:
                        NetworkImage("https://image.tmdb.org/t/p/w500$poster"),
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
                  truncate(movieName, length: 20),
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
                  "Release: $movieRelease",
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
                  "Rate: ${voteAverage.toString()}",
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
        ),
        // Positioned(
        //   right: 1,
        //   bottom: 15,
        //   child: IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.favorite,
        //         color: Colors.red,
        //       )),
        // ),
      ],
    );
  }

  // this function is to reduce the title size
  String truncate(String text, {length: 7, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }
}
