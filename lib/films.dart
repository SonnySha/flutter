import 'package:flutter/material.dart';

import 'widget/moviesMDB.dart';

class FilmArchive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
          child: Stack(fit: StackFit.expand, children: [
        Container(
            color: Colors.black,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                MoviesMDB(
                  titleMdb: 'Popular Movies',
                  urlMdb:
                      'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=62feaff3d2cf094a340f530fbf25bde9',
                ),
                MoviesMDB(
                  titleMdb: 'Best TV Shows',
                  urlMdb:
                      'https://api.themoviedb.org/3/discover/movie?api_key=62feaff3d2cf094a340f530fbf25bde9&language=en-US&sort_by=release_date.asc&include_adult=false&include_video=false&page=1',
                ),
                MoviesMDB(
                  titleMdb: 'Best Movies',
                  urlMdb:
                      'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=62feaff3d2cf094a340f530fbf25bde9',
                ),
              ],
            ))
      ])),
    );
  }
}
