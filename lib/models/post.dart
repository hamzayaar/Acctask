import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String userId;
  String content;
  int likes;
  List<String> comments;

  Post(
      {required this.id,
      required this.userId,
      required this.content,
      this.likes = 0,
      this.comments = const []});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      userId: doc['userId'],
      content: doc['content'],
      likes: doc['likes'] ?? 0,
      comments: List<String>.from(doc['comments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'likes': likes,
      'comments': comments,
    };
  }
}
