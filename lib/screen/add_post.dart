import 'package:acctask/utility/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Post content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  PostController.instance.addPost(_controller.text);
                  Get.back();
                }
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
