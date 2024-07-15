// import 'package:acctask/screen/signin_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class FeedScreen extends StatefulWidget {
//   @override
//   _FeedScreenState createState() => _FeedScreenState();
// }

// class _FeedScreenState extends State<FeedScreen> {
//   final TextEditingController postController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   File? _image;

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _uploadPost() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String? imageUrl;
//       if (_image != null) {
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('post_images')
//             .child(DateTime.now().toString() + '.jpg');
//         await storageRef.putFile(_image!);
//         imageUrl = await storageRef.getDownloadURL();
//       }

//       await FirebaseFirestore.instance.collection('posts').add({
//         'text': postController.text,
//         'userId': user.uid,
//         'username': user.email,
//         'createdAt': Timestamp.now(),
//         'imageUrl': imageUrl,
//         'likesCount': 0,
//       });

//       postController.clear();
//       setState(() {
//         _image = null;
//       });
//     }
//   }

//   void _showCommentBottomSheet(String postId) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         final commentController = TextEditingController();
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: commentController,
//                 decoration: InputDecoration(labelText: 'Add a comment'),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   final user = FirebaseAuth.instance.currentUser;
//                   if (user != null) {
//                     await FirebaseFirestore.instance
//                         .collection('posts')
//                         .doc(postId)
//                         .collection('comments')
//                         .add({
//                       'text': commentController.text,
//                       'userId': user.uid,
//                       'username': user.email,
//                       'createdAt': Timestamp.now(),
//                     });
//                     commentController.clear();
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('Post Comment'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _likePost(String postId, int currentLikes) async {
//     await FirebaseFirestore.instance.collection('posts').doc(postId).update({
//       'likesCount': currentLikes + 1,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feed'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Get.offAll(() => LoginScreen());
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: postController,
//                     decoration: InputDecoration(labelText: 'Write a post'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_a_photo),
//                   onPressed: _pickImage,
//                 ),
//               ],
//             ),
//           ),
//           if (_image != null) Image.file(_image!),
//           ElevatedButton(
//             onPressed: _uploadPost,
//             child: Text('Post'),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('posts')
//                   .orderBy('createdAt', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData)
//                   return Center(child: CircularProgressIndicator());

//                 final posts = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: posts.length,
//                   itemBuilder: (context, index) {
//                     final post = posts[index];
//                     return ListTile(
//                       leading: post['imageUrl'] != null
//                           ? Image.network(post['imageUrl'])
//                           : null,
//                       title: Text(post['text']),
//                       subtitle: Text(
//                           'By: ${post['username']} \nLikes: ${post['likesCount']}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.thumb_up),
//                             onPressed: () {
//                               _likePost(post.id, post['likesCount']);
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.comment),
//                             onPressed: () {
//                               _showCommentBottomSheet(post.id);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
