import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc.dart';
import '../models/post.dart';
import 'dart:math';

class CreatePostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _createPost(BuildContext context) {
    final newPost = Post(
      id: Random().nextInt(1000).toString(),
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<PostBloc>().add(AddPost(newPost));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => _createPost(context), child: const Text('Create Post')),
          ],
        ),
      ),
    );
  }
}
