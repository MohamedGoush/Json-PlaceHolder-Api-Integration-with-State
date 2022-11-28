import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_placeholder_state/models/PostModel.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var _posts = <Posts>[];

  Future<List<Posts>> fetchPosts() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    var posts = <Posts>[];
    if (response.statusCode == 200) {
      var postsJson = jsonDecode(response.body);
      for (var postJson in postsJson) {
        posts.add(Posts.fromJson(postJson));
      }
    }

    return posts;
  }

  @override
  void initState() {
    fetchPosts().then((value) {
      setState(() {
        _posts.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "UserId :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _posts[index].userId!.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Id :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _posts[index].id!.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Title :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _posts[index].title!,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Body :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _posts[index].body!,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
