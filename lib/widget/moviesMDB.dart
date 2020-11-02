import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../movie.dart';

class RepoMovies {
  static Future<List<Movie>> fetchData(String urlAPI) async {
    // String url =
    //     "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=62feaff3d2cf094a340f530fbf25bde9";
// "https://api.themoviedb.org/3/discover/movie?api_key=62feaff3d2cf094a340f530fbf25bde9&language=en-US&sort_by=release_date.asc&include_adult=false&include_video=false&page=1";
    String url = urlAPI;

    final response = await http.get(url);
    List<Movie> lstMovies = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      for (var i = 0; i < jsonResponse['results'].length; i++) {
        lstMovies.add(Movie(
            jsonResponse['results'][i]['id'],
            jsonResponse['results'][i]['title'],
            jsonResponse['results'][i]['poster_path'],
            jsonResponse['results'][i]['adult'],
            jsonResponse['results'][i]['vote_average'].toDouble(),
            jsonResponse['results'][i]['genre_ids']));
      }

      return lstMovies;
    } else {
      return lstMovies;
    }
  }
}

class Movie {
  final int id;
  final String title;
  final String image;
  final bool isAdult;
  final double voteAverage;
  final List<dynamic> genres;

  Movie(this.id, this.title, this.image, this.isAdult, this.voteAverage,
      this.genres);
}

class MoviesMDB extends StatelessWidget {
  MoviesMDB({Key key, this.titleMdb, this.urlMdb}) : super(key: key);

  final String titleMdb;
  final String urlMdb;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: Text(titleMdb,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
        FutureBuilder(
            future: RepoMovies.fetchData(urlMdb),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Movie movie = snapshot.data[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoviePage(
                                        movie: movie,
                                      )),
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                      'https://image.tmdb.org/t/p/w500/' +
                                          movie.image))));
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })
      ],
    );
  }
}
