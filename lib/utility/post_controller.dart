import 'package:acctask/widget/commentwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var posts = <Post>[].obs;

  @override
  void onReady() {
    posts.bindStream(getPosts());
    super.onReady();
  }

  Stream<List<Post>> getPosts() {
    return _db
        .collection('posts')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Post.fromDocument(doc)).toList())
        .handleError((error) {
      print("Error fetching posts: $error");
    });
  }

  Future<void> addPost(String content) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db.collection('posts').add({
        'content': content,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
        'likes': [],
      });
    }
  }

  Future<void> addComment(String postId, String content) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db.collection('posts').doc(postId).collection('comments').add({
        'content': content,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<List<Comment>> getComments(String postId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList());
  }

  Stream<List<Post>> getUserPosts(String userId) {
    return _db
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Post.fromDocument(doc)).toList());
  }

  
}

class Post {
  final String id;
  final String content;
  final String userId;
  final Timestamp timestamp;
  bool isLiked;

  Post({
    required this.id,
    required this.content,
    required this.userId,
    required this.timestamp,
    this.isLiked = false,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      content:
          doc['content'] ?? '', // Provide default value if field is missing
      userId: doc['userId'] ?? '', // Provide default value if field is missing
      timestamp: doc['timestamp'] ??
          Timestamp.now(), // Provide default value if field is missing
    );
  }
}
