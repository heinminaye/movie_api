import 'dart:convert';
import 'dart:math';

import 'sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var popular;
  List list = [];
  bool choose = true;

  void getTv() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/tv/popular?api_key=ca097bbfb936488fa086f014cbde2ac6&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var urlResponse = jsonDecode(response.body);
      setState(() {
        list = urlResponse['results'];
      });
    } else {
      print(response.statusCode);
    }
  }

  void getTheaters() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=ca097bbfb936488fa086f014cbde2ac6&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var urlResponse = jsonDecode(response.body);
      setState(() {
        list = urlResponse['results'];
      });
    } else {
      print(response.statusCode);
    }
  }

  void chooseBtn() {
    setState(() {
      choose = !choose;
    });
  }

  @override
  void initState() {
    getTv();
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
                    onPressed: () {
                      Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          onPressed: () {
                            setState(() {
                              chooseBtn();
                              getTv();
                            });
                          },
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
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent),
                          onPressed: () {
                            setState(() {
                              chooseBtn();
                              getTheaters();
                            });
                          },
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
            Flexible(
              child: (list == [])
                  ? const Center(
                      child: SpinKitFoldingCube(
                        color: Colors.white,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var vote = list[index]['vote_average'];
                          var vote_average = vote * 10;
                          var circular_average = vote / 10;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: SizedBox(
                              width: 180,
                              child: Column(
                                children: [
                                  Container(
                                    height: 270,
                                    child: Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.network(
                                              "https://image.tmdb.org/t/p/original${list[index]['poster_path']}",
                                              width: 200,
                                              fit: BoxFit.cover, frameBuilder:
                                                  (context, child, frame,
                                                      wasSynchronouslyLoaded) {
                                            return child;
                                          }, loadingBuilder: (context, child,
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Container(
                                                height: 200,
                                                child: const Center(
                                                  child: SpinKitCircle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        top: 230,
                                        child: SizedBox(
                                          width: 40,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.black,
                                              radius: 20,
                                              child: SizedBox(
                                                  child: Stack(
                                                children: <Widget>[
                                                  Center(
                                                    child: Container(
                                                      child:
                                                          CircularProgressIndicator(
                                                              value:
                                                                  circular_average,
                                                              strokeWidth: 2,
                                                              color: (circular_average <
                                                                      0.5)
                                                                  ? Colors.red
                                                                  : (circular_average <
                                                                          0.7)
                                                                      ? Colors
                                                                          .yellow
                                                                      : Colors
                                                                          .greenAccent),
                                                    ),
                                                  ),
                                                  Center(
                                                      child: Text(
                                                    "$vote_average%",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                                ],
                                              ))),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        (choose == false)
                                            ? "${list[index]['title']}"
                                            : "${list[index]['name']}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        (choose == false)
                                            ? "${list[index]['release_date']}"
                                            : "${list[index]['first_air_date']}",
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
            )
          ],
        ),
      ),
    );
  }
}
