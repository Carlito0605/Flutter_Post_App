import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repositories/post_repository.dart';
import '../models/post.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;
  AddPost(this.post);

  @override
  List<Object?> get props => [post];
}

class UpdatePost extends PostEvent {
  final Post post;
  UpdatePost(this.post);

  @override
  List<Object?> get props => [post];
}

class DeletePost extends PostEvent {
  final String postId;
  DeletePost(this.postId);

  @override
  List<Object?> get props => [postId];
}

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostError extends PostState {
  final String message;
  PostError(this.message);

  @override
  List<Object?> get props => [message];
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository = PostRepository();

  PostBloc() : super(PostLoading()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await repository.getAllPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    await repository.createPost(event.post);
    add(FetchPosts());
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    await repository.updatePost(event.post);
    add(FetchPosts());
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    await repository.deletePost(event.postId);
    add(FetchPosts());
  }
}
