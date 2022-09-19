import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BookingWidget extends StatelessWidget {
   BookingWidget({Key? key}) : super(key: key);

  var t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Booking").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error : " + snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          data["movie"].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(data["overview"].toString()),
                        Text("Jumlah Tiket Yang Dipesan : " +
                            data["jumlah"].toString()),
                        Divider(),
                        IconButton(
                            onPressed: () async {
                              await showModalBottomSheet(
                                // isScrollControlled: true,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            20),
                                    child: ListView(
                                      children: [
                                        Text(data["movie"].toString()),
                                        Text(data["overview"].toString()),
                                        TextFormField(
                                          controller: t1,
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              var qty = t1.text;
                                              await FirebaseFirestore.instance
                                              .collection("Booking")
                                              .doc(data.id)
                                              .update({"jumlah" : qty});
                                            Navigator.of(context).pop();
                                            },
                                            child: Text("Update jumlah!"))
                                      ],
                                    ),
                                  );
                                },
                                context: context,
                              );
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Confirmation"),
                                      content: Text("Are You Sure"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("Booking")
                                                  .doc(data.id)
                                                  .delete();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Yes")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No")),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
