import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailWidget extends StatelessWidget {
  var id = "";
  var tc = TextEditingController();

  saveBooking(movie, overview) async {
    var qty = tc.text;
    var email = FirebaseAuth.instance.currentUser!.email;
    var fs = FirebaseFirestore.instance;

    await fs.collection("Booking").add({
      "movie": movie,
      "overview": overview,
      "jumlah": qty,
      "email": email,
    });
  }

  Future detailMovie() async {
    var uri = Uri.https("api.themoviedb.org", "/3/movie/" + id,
        {"api_key": "c619bb5b94bf31f9cbdb8bfb67fe4191"});

    var response = await http.get(uri);
    var hasil = json.decode(response.body);

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: FutureBuilder(
        future: detailMovie(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var movie = snapshot.data as Map<String, dynamic>;

            return Stack(fit: StackFit.expand, children: [
              CachedNetworkImage(
                  errorWidget: (context, a, b) {
                    return Text("No Image");
                  },
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500" + movie["poster_path"]),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                  )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                          errorWidget: (context, a, b) {
                            return Text("No Image");
                          },
                          imageUrl: "https://image.tmdb.org/t/p/w500" +
                              movie["poster_path"],
                          height: 250,
                          width: 250),
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              offset: new Offset(0.0, 10.0))
                        ],
                      ),
                    ),
                    Divider(),
                    Text(
                      movie["title"],
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(movie["overview"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {}, child: Row(
                            children: [
                              Text("Rate This Movie"),
                              Icon(Icons.rate_review),
                            ],
                          )),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.save),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: 
                              TextFormField(
                              controller: tc,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              maxLength: 2,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.book_online),
                                iconColor: Colors.blue,
                                hintText: "Qty",
                                hintStyle: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                          ),
                            ),
                            IconButton(onPressed: () async {
                              await saveBooking(movie["title"], movie["overview"]);
                              Navigator.pushNamed(context, 'booking_page');
                            }, icon: Icon(Icons.book_online_outlined),
                            color: Colors.blueAccent,),
                  ],
                ),
              )
            ]);
          } else if (snapshot.hasError) {
            return Text("Load Data Error");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
