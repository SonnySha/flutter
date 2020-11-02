import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'widget/moviesMDB.dart';

class MoviePage extends StatefulWidget {
  MoviePage({Key key, this.movie}) : super(key: key);

  final Movie movie;

  _MoviePage createState() => _MoviePage();
}

class _MoviePage extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.movie.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: RepoMovieDetail.fetchMovieDetail(widget.movie.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                MovieDetail filmDetail = snapshot.data;
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // Image.asset(
                    //   'assets/images/enola.jpg',
                    //   fit: BoxFit.cover,
                    // ),
                    Image.network(
                        'https://image.tmdb.org/t/p/w500/' + filmDetail.image,
                        fit: BoxFit.cover),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [
                              0.87,
                              1
                            ],
                                colors: [
                              const Color.fromARGB(255, 46, 42, 44),
                              Colors.transparent
                            ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              child: Text(
                                filmDetail.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          filmDetail.isAdult ? '+18 ' : '-18 ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: filmDetail.voteAverage.toString(),
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold))
                                ],
                              )),
                            ),
                            Container(
                              height: 30,
                              margin: const EdgeInsets.only(left: 20),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filmDetail.genres.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(6.0),
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(5.0),
                                            topRight:
                                                const Radius.circular(5.0),
                                            bottomLeft:
                                                const Radius.circular(5.0),
                                            bottomRight:
                                                const Radius.circular(5.0))),
                                    child: Text(
                                        filmDetail.genres[index]['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 10),
                              child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Cast: ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Millie Bobby Brown  Henry Cavill',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic)),
                                ],
                              )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                "Summary",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 20, bottom: 10),
                              child: Text(
                                filmDetail.overview,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class RepoMovieDetail {
  static Future<MovieDetail> fetchMovieDetail(int id) async {
    String url =
        "https://api.themoviedb.org/3/movie/${id}?api_key=62feaff3d2cf094a340f530fbf25bde9&language=en-US";
    final response = await http.get(url);
    // List<Genre> lstGenres = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var film = new MovieDetail(
          jsonResponse['title'],
          jsonResponse['poster_path'],
          jsonResponse['adult'],
          jsonResponse['vote_average'],
          jsonResponse['genres'],
          jsonResponse['overview']);

      return film;
    } else {
      return new MovieDetail('', '', false, 0.00, [], '');
    }
  }
}

class MovieDetail {
  final String title;
  final String image;
  final bool isAdult;
  final double voteAverage;
  final List<dynamic> genres;
  final String overview;

  MovieDetail(this.title, this.image, this.isAdult, this.voteAverage,
      this.genres, this.overview);
}
