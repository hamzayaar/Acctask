// import 'package:get/get.dart';
// import '../models/post_model.dart';
// import '../services/firestore_service.dart';

// class FeedController extends GetxController {
//   var posts = <Post>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPosts();
//   }

//   void fetchPosts() async {
//     posts.value = await FirestoreService.getPosts();
//   }

//   void addPost(String content) async {
//     await FirestoreService.addPost(content);
//     fetchPosts();
//   }

//   void likePost(String postId) async {
//     await FirestoreService.likePost(postId);
//     fetchPosts();
//   }

//   void addComment(String postId, String comment) async {
//     await FirestoreService.addComment(postId, comment);
//     fetchPosts();
//   }
// }
