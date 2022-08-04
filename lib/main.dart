import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var popular;
  List list = [];

  void getPopular() async {
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

  @override
  void initState() {
    getPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                            Stack(children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: Image.network(
                                      "https://image.tmdb.org/t/p/original${list[index]['poster_path']}",
                                      width: 200,
                                      fit: BoxFit.cover, frameBuilder: (context,
                                          child,
                                          frame,
                                          wasSynchronouslyLoaded) {
                                    return child;
                                  }, loadingBuilder:
                                          (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Container(
                                        height: 200,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  }),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 220,
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
                                              child: CircularProgressIndicator(
                                                  value: circular_average,
                                                  strokeWidth: 2,
                                                  color: (circular_average <
                                                          0.5)
                                                      ? Colors.red
                                                      : (circular_average < 0.7)
                                                          ? Colors.yellow
                                                          : Colors.greenAccent),
                                            ),
                                          ),
                                          Center(
                                              child: Text(
                                            "$vote_average%",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))
                                        ],
                                      ))),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "${list[index]['title']}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                "${list[index]['release_date']}",
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
    );
  }
}
