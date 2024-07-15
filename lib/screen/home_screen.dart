import 'package:acctask/screen/add_post.dart';
import 'package:acctask/screen/profile_screen.dart';
import 'package:acctask/utility/auth_controller.dart';
import 'package:acctask/widget/commentwidget.dart';
import 'package:acctask/utility/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Get.to(ProfilePage());
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthController.instance.signOut();
            },
          ),
        ],
      ),
      body: PostFeed(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPostPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostFeed extends StatefulWidget {
  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (PostController.instance.posts.isEmpty) {
        return Center(child: Text('No posts available. Please add a post.'));
      } else {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: PostController.instance.posts.length,
          itemBuilder: (context, index) {
            final post = PostController.instance.posts[index];
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
        );
      }
    });
  }
}
