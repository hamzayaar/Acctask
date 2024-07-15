import 'package:acctask/utility/post_controller.dart';
import 'package:acctask/widget/commentwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final postController = Get.put(PostController());

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Obx(() {
        var userPosts = postController.posts
            .where((post) => post.userId == user.uid)
            .toList();
        if (userPosts.isEmpty) {
          return Center(child: Text('No posts yet'));
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Username : ${user.email.toString()} "),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: userPosts.length,
              itemBuilder: (context, index) {
                final post = userPosts[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            CommentsPage(post: post),
                            isScrollControlled: true,
                          );
                        },
                        icon: Icon(Icons.comment)),
                    title: Text(post.content.toString()),
                    subtitle: Text(
                      post.timestamp.toDate().toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: post.isLiked ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          post.isLiked = !post.isLiked;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
