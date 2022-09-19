import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HolidayWidget extends StatelessWidget {
   HolidayWidget({ Key? key }) : super(key: key);

Future getlistholidays() async {
  var uri = Uri.https("holidayapi.com", "/v1/holidays",{
    "key": "9bc9072e-0ff1-4f37-bdfc-5872328fbecc", "country": "ID", "year": "2021"
    });
  var response = await http.get(uri);
  var hasil = json.decode(response.body);

  return hasil;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Holiday page"),
        centerTitle: true,
        ),
        body: FutureBuilder(
          future: getlistholidays(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
            if (snapshot.hasData) {
              var listHoliday = snapshot.data as Map<String, dynamic>;
              var holidays = listHoliday["holidays"] as List<dynamic>;



                return ListView.builder(
                itemCount: holidays.length,
                itemBuilder: (context, index) {
                var libur = holidays[index] as Map<String, dynamic>;


                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                      Text("Nama hari libur : " + libur["name"].toString()),
                      Text("Tanggal hari libur : " + libur["date"].toString()),
                    ]),
                );


                });

            } else if (snapshot.hasError) {
              return Center(child: Text("Load Data Failed"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
           },),
    );
  }
}