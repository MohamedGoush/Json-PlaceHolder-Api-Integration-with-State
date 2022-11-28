import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_placeholder_state/models/CommentModel.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var _comments = <Comments>[];

  Future<List<Comments>> fetchComments() async {
    String url = "https://jsonplaceholder.typicode.com/comments";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    var comments = <Comments>[];
    if (response.statusCode == 200) {
      var commentsJson = jsonDecode(response.body);
      for (var commentJson in commentsJson) {
        comments.add(Comments.fromJson(commentJson));
      }
    }

    return comments;
  }

  @override
  void initState() {
    fetchComments().then((value) {
      setState(() {
        _comments.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments Page"),
      ),
      body: ListView.builder(
        itemCount: _comments.length,
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
                    "PostId :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _comments[index].postId.toString(),
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
                    _comments[index].id!.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _comments[index].name!,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email :",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _comments[index].email!,
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
                    _comments[index].body!,
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
