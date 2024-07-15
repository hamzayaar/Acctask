import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utility/post_controller.dart';

class CommentsPage extends StatelessWidget {
  final Post post;

  CommentsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppBar(
                title: Text('Comments'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: CommentsList(postId: post.id),
              ),
              AddCommentSection(postId: post.id),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  final String postId;

  CommentsList({required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Comment>>(
      stream: PostController.instance.getComments(postId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final comments = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return ListTile(
              title: Text(comment.content),
              subtitle: Text(
                comment.timestamp.toDate().toString(),
                style: TextStyle(fontSize: 10),
              ),
            );
          },
        );
      },
    );
  }
}

class AddCommentSection extends StatelessWidget {
  final String postId;
  final TextEditingController _controller = TextEditingController();

  AddCommentSection({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Add a comment'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                PostController.instance.addComment(postId, _controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String id;
  final String content;
  final String userId;
  final Timestamp timestamp;

  Comment(
      {required this.id,
      required this.content,
      required this.userId,
      required this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      id: doc.id,
      content: doc['content'],
      userId: doc['userId'],
      timestamp: doc['timestamp'],
    );
  }
}
