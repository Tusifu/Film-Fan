import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final bool? isSmall;
  final String movieName;
  final String movieRelease;
  final String poster;
  const MovieCard({
    Key? key,
    this.isSmall = false,
    required this.movieName,
    required this.movieRelease,
    required this.poster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage("https://image.tmdb.org/t/p/w500$poster"),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          // const SizedBox(
          //   height: 15,
          // ),
          const Spacer(),
          Text(
            movieName,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movieRelease,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
