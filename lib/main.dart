import 'dart:convert';
import 'package:gallery_saver/gallery_saver.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String content_url = '';



  Future<void> fetchRandomImageUrl() async {
    String post="";

    do {
      final response = await http.get(
        Uri.parse('https://www.reddit.com/r/Awww/random.json'),
      );
      final jsonData = jsonDecode(response.body);

      post = (jsonData[0]['data']['children'][0]['data']["url"])
          .toString();

      print(post);
    }while(!post.endsWith(".jpg")&&!post.endsWith(".png")&&!post.contains("imgur.com"));
    if(post.contains("imgur.com")) {
      post = "https://i."+post.split("https://")[1]+".jpeg";
    }
    print(post);
    setState(() {

      content_url=post;
    });
  }





  @override
  void initState() {
    super.initState();

    fetchRandomImageUrl();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              fetchRandomImageUrl();
            },
            child:Image.network(content_url,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height   ,
            )

        ),
      ),
       floatingActionButton: ElevatedButton(
        onPressed: () {  /*GallerySaver.saveImage(content_url);*/},
        child: Icon(Icons.download),

      ) ,

    );
  }
}
