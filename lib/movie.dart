import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieWidget extends StatefulWidget {
  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  Future newMovies() async {
    var uri = Uri.https("api.themoviedb.org", "/3/movie/upcoming", {
      "api_key": "c619bb5b94bf31f9cbdb8bfb67fe4191",
    });
  
    if (selectedTab == 0) {
      uri = Uri.https("api.themoviedb.org", "/3/movie/top_rated",
          {"api_key": "c619bb5b94bf31f9cbdb8bfb67fe4191"});
    } else if (selectedTab == 1) {
      uri = Uri.https("api.themoviedb.org", "/3/movie/now_playing",
          {"api_key": "c619bb5b94bf31f9cbdb8bfb67fe4191"});
    }

    var response = await http.get(uri);
    var hasil = json.decode(response.body);

    return hasil;
  }

  int selectedTab = 0;

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                if (isSearching == true) {
                  isSearching = false;
                } else {
                  isSearching = true;
                }
                setState(() {});
              },
              child: Icon(isSearching ? Icons.cancel : Icons.search)),
          Icon(Icons.bubble_chart),
        ],
        title: isSearching
            ? TextFormField(
                onFieldSubmitted: (Value) {
                  Navigator.pushNamed(context, 'result_page', arguments: Value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: ("Search Movie..."),
                ),
              )
            : Text("List Movie"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) {
          selectedTab = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              label: "Now Playing Movie", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Top Rated Movie", icon: Icon(Icons.star)),
          BottomNavigationBarItem(
              label: "Upcoming Movie", icon: Icon(Icons.calendar_month)),
        ],
      ),
      body: FutureBuilder(
        future: newMovies(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as Map<String, dynamic>;
            var results = data["results"] as List<dynamic>;

            return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var movie = results[index] as Map<String, dynamic>;
                  return ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/w500" +
                            movie["poster_path"],
                        placeholder: (context, url) {
                          return Center(child: CircularProgressIndicator());
                        },
                        height: 300,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            var id = movie["id"].toString();
                            Navigator.pushNamed(context, 'detail_page', 
                            arguments: id);
                          },
                          child: Text(
                            movie["title"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie["vote_average"].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text("Load Data Failed"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
