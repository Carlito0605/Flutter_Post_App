import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/post_bloc.dart';
import 'src/pages/post_list_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(FetchPosts()),
      child: MaterialApp(
        title: 'Flutter Posts App',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: PostListPage(),
      ),
    );
  }
}
