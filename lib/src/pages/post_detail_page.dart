import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc.dart';
import '../models/post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({required this.post});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
  }

  void _updatePost() {
    final updatedPost = Post(
      id: widget.post.id,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<PostBloc>().add(UpdatePost(updatedPost));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _updatePost, child: const Text('Save Changes')),
          ],
        ),
      ),
    );
  }
}
