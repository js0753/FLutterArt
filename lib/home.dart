import 'package:fanart/takePic.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_page.dart';
import 'package:fanart/posts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference myRef = database.reference();
DatabaseReference postRef = myRef.child('posts');

class Home extends StatefulWidget {
  final String username;
  final List<Widget> userPosts;
  final CameraDescription camera;

  Home(this.username, this.camera, this.userPosts);
  @override
  HomeState createState() => HomeState(
        username,
        camera,
        userPosts,
      );
}

class HomeState extends State<Home> {
  // This widget is the root of your application.
  String username;
  String user;
  String header;
  bool isOpen;
  bool menuOn;
  CameraDescription camera;
  List<Widget> homePosts = new List();
  List<Widget> userPosts;
  HomeState(this.username, this.camera, this.userPosts) {
    header = username;
    isOpen = false;
    menuOn = false;

    if (homePosts.length == 0) {
      postRef.once().then((DataSnapshot snapshot) {
        setState(() {});
        var x = snapshot.value;
        List<dynamic> values = snapshot.value;
        int counter = 0;
        for (Map x in values) {
          String temp = 'posts/' + counter.toString();
          addPost(refPath: temp);
          counter += 1;
        }
        ;
      });
    }
  }

  void addPost({String refPath}) {
    print("Ref path is : " + refPath);
    homePosts.add(FriendPost(ref: refPath));
  }

  @override
  Widget build(BuildContext context) {
    print(homePosts.length);
    return MaterialApp(
        title: header,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Stack(children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                "Other's Artpages",
                style: TextStyle(
                    fontFamily: 'ComicNeue',
                    fontSize: 15.0,
                    color: Colors.white,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Expanded(
                child: homePosts.length == 0
                    ? Container()
                    : ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: homePosts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return homePosts[homePosts.length - index - 1];
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
              ),
              SizedBox(
                height: 70,
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65.0,
              width: 300.0,
              margin: EdgeInsets.only(bottom: 35),
              decoration: BoxDecoration(
                  color: Colors.teal[200],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        tooltip: 'Search',
                        icon: Icon(Icons.search),
                        onPressed: null,
                      ),
                      IconButton(
                          tooltip: 'Click from Camera',
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TakePictureScreen(
                                  username: username,
                                  camera: camera,
                                  posts: userPosts,
                                  homePosts: homePosts,
                                ),
                              ),
                            );
                          }),
                      IconButton(
                          tooltip: 'Upload from Gallery',
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: _imgFromGallery),
                      IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile("user1",
                                      "user1", camera, userPosts, homePosts),
                                ),
                              )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]));
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    userPosts.add(new Post(username: username, img: Image.file(image)));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Profile("user1", "user1", camera, userPosts, homePosts),
      ),
    );
  }
}
