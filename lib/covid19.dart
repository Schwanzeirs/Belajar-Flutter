import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CovidWidget extends StatelessWidget {
  const CovidWidget({ Key? key }) : super(key: key);

  Future getdatacovid() async {
    var url = Uri.https("data.covid19.go.id", "public/api/update.json");
    var response = await http.get(url);
    var hasil = json.decode(response.body);
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Data harian Covid 19"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getdatacovid(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          if (snapshot.hasData) {
              var dataCovid = snapshot.data as Map<String, dynamic>;
              var data = dataCovid["data"] as Map<String, dynamic>;
              var update = dataCovid["update"] as Map<String, dynamic>;
              var penambahan = update["penambahan"] as Map<String, dynamic>;
              var harian = update["harian"] as List<dynamic>;


              return ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    margin: EdgeInsets.all(8),
                    elevation: 12,
                    child: 
                    Text("Jumlah ODP : " + data["jumlah_odp"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: 
                    Text("Jumlah PDP : " + data["jumlah_pdp"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    elevation: 12,
                    child: 
                    Text("Total Spesimen : " + data["total_spesimen"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: 
                    Text("Total Spesimen Negatif : " + data["total_spesimen_negatif"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    elevation: 12,
                    child: 
                    Text("Jumlah Positif : " + penambahan["jumlah_positif"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: 
                    Text("Jumlah Meninggal : " + penambahan["jumlah_meninggal"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    elevation: 12,
                    color: Colors.green,
                    child: 
                    Text("Jumlah Sembuh : " + penambahan["jumlah_sembuh"].toString())),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: 
                    Text("Jumlah Dirawat : " + penambahan["jumlah_dirawat"].toString())),

                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: harian.length,
                      itemBuilder: (context, index) { 
                        var data = harian[index] as Map<String, dynamic>;
                        var jmlsembuh = data["jumlah_sembuh"] as Map<String, dynamic>;

                        return Text(data["key_as_string"] + " : " + jmlsembuh["value"].toString());
                       },)
                    
                ],
              );
              


          } else if (snapshot.hasError) {
            return Center(child: Text("Error to load data"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
         },),
    );
  }
}