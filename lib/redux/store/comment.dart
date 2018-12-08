
class Comment {
  final String id;
  final String author;
  final String hash;
  final int createdAt;

  Comment({
    this.id,
    this.author,
    this.hash,
    this.createdAt,
  });

  Comment.fromJson(Map<String, dynamic> json)
      :
        this.id = json['id'],
        this.author = json['author'],
        this.hash = json['cmt_hash'],
        this.createdAt = json['created_at'];

  @override
  String toString() {
    return 'Comment{id: $id, author: $author, hash: $hash, createdAt: $createdAt}';
  }
}
