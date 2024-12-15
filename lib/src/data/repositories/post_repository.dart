import '../data_sources/fake_posts_data_source.dart';
import '../../models/post.dart';

class PostRepository {
  final FakePostsDataSource dataSource = FakePostsDataSource();

  Future<List<Post>> getAllPosts() => dataSource.getAllPosts();

  Future<Post> createPost(Post post) => dataSource.createPost(post);

  Future<Post> updatePost(Post post) => dataSource.updatePost(post);

  Future<void> deletePost(String id) => dataSource.deletePost(id);
}
