import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryWidget extends StatelessWidget {
  const CountryWidget({Key? key}) : super(key: key);

  Future getlistcountries() async {
    var url = Uri.https("restcountries.com", "v3.1/all");
    var response = await http.get(url);
    var hasil = json.decode(response.body);
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Country"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getlistcountries(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List<dynamic>;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var country = data[index] as Map<String, dynamic>;
                  var name = country["name"] as Map<String, dynamic>;
                  var flags = country["flags"] as Map<String, dynamic>;
                  var coatOfArms =
                      country["coatOfArms"] as Map<String, dynamic>;

                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          flags["png"].toString(),
                          width: 15,
                          height: 15,
                        ),
                      ),
                      Text(name["common"].toString()),
                      coatOfArms["png"] != null
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(coatOfArms["png"],
                            width: 15,
                            height: 15,),
                          )
                          : Container(),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text("Please try again"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
