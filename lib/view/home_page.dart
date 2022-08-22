import 'dart:convert';
import 'package:api/model/response_movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../components/movie_data.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/response_tv.dart';
import '../model/response_movie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Result> moviePopular = [];
  List<Tv> topRated = [];
  bool choose = false;

  getMoviePopular() async {
    await Api().getMoviePopular("popular").then((value) {
      if (this.mounted) {
        setState(() {
          moviePopular = value;
        });
      }
    });
  }

  getTrending() async {
    await API().getTvPopular("popular").then((value) {
      if (this.mounted) {
        setState(() {
          topRated = value;
        });
      }
    });
  }

  void chooseBtn() {
    setState(() {
      choose = !choose;
    });
  }

  @override
  void initState() {
    getMoviePopular();
    super.initState();
    getTrending();
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              children: [
                const Text(
                  "What's Popular",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(children: [
                    ElevatedButton(
                        style: (choose == true)
                            ? ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )))
                            : ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent),
                        onPressed: (choose == false)
                            ? () {
                                setState(() {
                                  chooseBtn();
                                  getTrending();
                                });
                              }
                            : () {},
                        child: Text(
                          "On TV",
                          style: (choose == false)
                              ? const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)
                              : const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        style: (choose == false)
                            ? ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )))
                            : ElevatedButton.styleFrom(
                                onSurface: Colors.blueAccent,
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent),
                        onPressed: (choose == true)
                            ? () {
                                setState(() {
                                  chooseBtn();
                                  getMoviePopular();
                                });
                              }
                            : () {},
                        child: Text(
                          "On Theaters",
                          style: (choose == true)
                              ? const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)
                              : const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                        ))
                  ]),
                )
              ],
            ),
          ),
          (choose == true)
              ? Flexible(
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
                                    releaseDate:
                                        moviePopular[index].releaseDate,
                                    rating: vote_average,
                                    circularAverage: circular_average,
                                  ),
                                ],
                              );
                            },
                          )),
                )
              : Flexible(
                  child: (moviePopular.isEmpty)
                      ? const Center(
                          child: SpinKitFoldingCube(
                            color: Colors.grey,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ListView.builder(
                            itemCount: topRated.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var vote = topRated[index].voteAverage;
                              var vote_average = vote * 10;
                              var circular_average = vote / 10;

                              return Column(
                                children: [
                                  CustomMovie(
                                    movieTitle: topRated[index].name,
                                    image: topRated[index].posterPath,
                                    releaseDate: topRated[index].firstAirDate,
                                    rating: vote_average,
                                    circularAverage: circular_average,
                                  ),
                                ],
                              );
                            },
                          )),
                )
        ],
      ),
    );
  }
}
