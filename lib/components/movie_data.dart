import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomMovie extends StatelessWidget {
  String movieTitle;
  String image;
  DateTime releaseDate;
  dynamic circularAverage;
  dynamic rating;

  CustomMovie({
    Key? key,
    required this.movieTitle,
    required this.image,
    required this.releaseDate,
    required this.rating,
    required this.circularAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            primary: Colors.transparent,
            elevation: 0),
        onPressed: () {},
        child: SizedBox(
          width: 180,
          child: Column(
            children: [
              Container(
                height: 270,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                          "https://image.tmdb.org/t/p/original$image",
                          width: 200,
                          fit: BoxFit.cover, frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      }, loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            height: 200,
                            width: 200,
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
                    left: 0,
                    top: 200,
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
                                      value: circularAverage,
                                      strokeWidth: 2,
                                      color: (circularAverage < 0.5)
                                          ? Colors.red
                                          : (circularAverage < 0.7)
                                              ? Colors.yellow
                                              : Colors.greenAccent),
                                ),
                              ),
                              Container(
                                height: 200,
                                child: Center(
                                    child: Text(
                                  "$rating%",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              )
                            ],
                          ))),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    movieTitle,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    DateFormat('MMMM dd, yyyy').format(releaseDate).toString(),
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
