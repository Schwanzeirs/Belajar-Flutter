import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultWidget extends StatelessWidget {
  var searching = "";

  Future searchMovie() async {
    var uri = Uri.https("api.themoviedb.org", "/3/search/movie",
        {"api_key": "c619bb5b94bf31f9cbdb8bfb67fe4191", "query": searching});

    var response = await http.get(uri);
    var hasil = json.decode(response.body);

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    searching = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: searchMovie(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as Map<String, dynamic>;
            var results = data["results"] as List<dynamic>;

            return GridView.builder(
                itemCount: results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var movie = results[index] as Map<String, dynamic>;

                  return movie["poster_path"] == null ? Container () : CachedNetworkImage(
                    errorWidget: (context, a, b) {
                      return Text("No Image");
                    },
                    imageUrl: "https://image.tmdb.org/t/p/w500" + 
                    movie["poster_path"]);
            });
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
