import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_placeholder_state/views/CommentPage.dart';
import 'package:json_placeholder_state/views/PostPage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _notes = <Notes>[];

  Future<List<Notes>> fetchData() async {
    String url = "https://jsonplaceholder.typicode.com/albums";
    final response = await http.get(Uri.parse(url));
    var notes = <Notes>[];
    if (response.statusCode == 200) {
      var notesJson = jsonDecode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Notes.fromJson(noteJson));
      }
    }

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    fetchData().then(
      (value) => _notes.addAll(value),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Data"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPage(),
                  ),
                );
              },
              child: Text(
                "Posts",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentPage(),
                  ),
                );
              },
              child: Text(
                "Comments",
              ),
            ),
          ],
        ),
      ),
    );

    // ListView.builder(
    //   itemCount: _notes.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       height: 100,
    //       child: Card(
    //         child: Center(
    //             child: Text(
    //           _notes[index].title!,
    //           style: TextStyle(
    //             fontSize: 24,
    //           ),
    //         )),
    //       ),
    //     );
    //   },
    // );
  }
}

class Notes {
  int? userId;
  int? id;
  String? title;

  Notes({this.userId, this.id, this.title});

  Notes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
