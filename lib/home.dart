import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/data/menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var m1 = Menu();
    m1.title = "Go Ride";
    m1.icon = Icons.motorcycle;
    m1.warna = Colors.green;

    var m2 = Menu();
    m2.title = "Go car";
    m2.icon = Icons.local_taxi;
    m2.warna = Colors.green;

    var m3 = Menu();
    m3.title = "Go Food";
    m3.icon = Icons.food_bank;
    m3.warna = Colors.red;

    var m4 = Menu();
    m4.title = "Go Send";
    m4.icon = Icons.add_box;
    m4.warna = Colors.green;

    var m5 = Menu();
    m5.title = "Go Mart";
    m5.icon = Icons.shopping_basket;
    m5.warna = Colors.brown;

    var m6 = Menu();
    m6.title = "Go Pulsa";
    m6.icon = Icons.smartphone;
    m6.warna = Colors.blue;

    var m7 = Menu();
    m7.title = "Check In";
    m7.icon = Icons.health_and_safety;
    m7.warna = Colors.blue;

    var m8 = Menu();
    m8.title = "Lainnya";
    m8.icon = Icons.settings;
    m8.warna = Colors.brown;

    List<Menu> allMenu = [];
    allMenu.add(m1);
    allMenu.add(m2);
    allMenu.add(m3);
    allMenu.add(m4);
    allMenu.add(m5);
    allMenu.add(m6);
    allMenu.add(m7);
    allMenu.add(m8);

    List<String> imgList = [
      'https://static.wikia.nocookie.net/blue-archive/images/9/9f/Millennium_Intro.png/revision/latest?cb=20210207075347',
      'https://static.wikia.nocookie.net/blue-archive/images/1/19/Trinity_Intro.png/revision/latest?cb=20210207075406',
      'https://static.wikia.nocookie.net/blue-archive/images/f/f4/Gehenna_Intro.png/revision/latest?cb=20210207075339',
      'https://static.wikia.nocookie.net/blue-archive/images/c/c9/Hyakkiyako_Intro.png/revision/latest?cb=20210218153020',
      'https://static.wikia.nocookie.net/blue-archive/images/b/bb/Abydos_Intro.png/revision/latest?cb=20210207074720',
      'https://static.wikia.nocookie.net/blue-archive/images/f/f8/Red_Winter_Intro.png/revision/latest?cb=20210424044708',
      'https://static.wikia.nocookie.net/blue-archive/images/a/af/Shanhaijing_Intro.png/revision/latest?cb=20210904121505',
      'https://static.wikia.nocookie.net/blue-archive/images/2/2e/Valkyrie_Intro.png/revision/latest?cb=20210905084447',
      'https://static.wikia.nocookie.net/blue-archive/images/f/fa/Arius_Intro.png/revision/latest/scale-to-width-down/2000?cb=20220214164316'
    ];

    VideoPlayerController _controller;

    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {});

    _controller.play();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: allMenu.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  var m = allMenu[index];
                  return Column(
                    children: [
                      Icon(
                        m.icon,
                        color: m.warna,
                      ),
                      Text(m.title),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(autoPlay: true),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "login_page");
                          },
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000),
                        )),
                      ))
                  .toList(),
            ),
          ),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  _controller.play();
                },
              ),
              IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    _controller.pause();
                  }),
            ],
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.pink,
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.green, Colors.blue],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: [
                  Text("Game Development Department"),
                  Text(FirebaseAuth.instance.currentUser!.email!),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(Icons.home),
          //       ),
          //       Text("Home"),
          //     ],
          //   ),
          // ),

          ListTile(
            title: Text("Home"),
            subtitle: Text("This is home menu"),
            leading: Icon(Icons.home),
          ),
          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Fluttertoast.showToast(
                msg:
                    "Aplikasi ini dikembangkan oleh Game Development Department",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 15,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0,
              );
            },
            title: Text("About"),
            subtitle: Text("About us"),
            leading: Icon(Icons.call),
          ),

          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'maps_page');
            },
            title: Text("Map"),
            subtitle: Text("Open World Map"),
            leading: Icon(Icons.map),
          ),
          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'listview_page');
            },
            title: Text("Listview Builder"),
            subtitle: Text("Open builder page"),
            leading: Icon(Icons.access_alarm),
          ),

          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'covid_page');
            },
            title: Text("Covid 19"),
            subtitle: Text("Covid 19 Data Statistic page"),
            leading: Icon(Icons.vaccines)
          ),

          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'movie_page');
            },
            title: Text("List Movie"),
            subtitle: Text("List Movie Page"),
            leading: Icon(Icons.movie)
          ),

          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'booking_page');
            },
            title: Text("List Booking"),
            subtitle: Text("List Booking Movie"),
            leading: Icon(Icons.book_online)
          ),

          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'country_page');
            },
            title: Text("List Country"),
            subtitle: Text("Open country page"),
            leading: Icon(Icons.map,),),

          Divider(
            thickness: 3,
          ),

                    ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'holiday_page');
            },
            title: Text("List Holiday"),
            subtitle: Text("Open holiday page"),
            leading: Icon(Icons.calendar_month,),),

          Divider(
            thickness: 3,
          ),

          ListTile(
            onTap: () async {
              var fb = FirebaseAuth.instance;
              await fb.signOut();
              Navigator.pushNamed(context, "login_page");
            },
            title: Text("Logout"),
            subtitle: Text("We will miss you"),
            leading: Icon(Icons.settings),
          ),
          Divider(
            thickness: 3,
          ),
        ],
      )),
    );
  }
}
