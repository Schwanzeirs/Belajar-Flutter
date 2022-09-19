import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = ["Midori", "Momoi", "Arisu", "Yuzu"];

    return Scaffold(
        appBar: AppBar(
          title: Text("Builder"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              // return Text("Hello " + index.toString());
              if (index < 2) {
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Hello " + data[index],
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Hello " + data[index],
                    style: TextStyle(color: Colors.green),
                  ),
                );
              }
            }));
  }
}
