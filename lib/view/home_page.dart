import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../components/movie_data.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/response_all.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool isLoggedIn = true;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Result> moviePopular = [];
  List<Result> topRated = [];

  getMoviePopular() async {
    await Api().getTvPopular("popular").then((value) {
      if (this.mounted) {
        setState(() {
          moviePopular = value;
        });
      }
    });
  }

  getTrending() async {
    await Api().getTvPopular("top_rated").then((value) {
      if (this.mounted) {
        setState(() {
          topRated = value;
        });
      }
    });
  }

  @override
  void initState() {
    getMoviePopular();
    getTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Home',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text(
                      'SIGN OUT',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            )
          ])),
      body: Column(
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Container(
                width: double.infinity,
                child: const Text(
                  "What's Popular",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          Flexible(
            child: (moviePopular.isEmpty)
                ? const Center(
                    child: SpinKitFoldingCube(
                      color: Colors.grey,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                      itemCount: moviePopular.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var vote = moviePopular[index].voteAverage;
                        var vote_average = vote * 10;
                        var circular_average = vote / 10;

                        return Column(
                          children: [
                            CustomMovie(
                              movieTitle: moviePopular[index].title,
                              image: moviePopular[index].posterPath,
                              releaseDate: moviePopular[index].releaseDate,
                              rating: vote_average,
                              circularAverage: circular_average,
                            ),
                          ],
                        );
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
