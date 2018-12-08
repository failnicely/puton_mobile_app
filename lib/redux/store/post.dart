import 'dart:typed_data';

import 'package:puton/redux/store/comment.dart';

class Post {
  final int id;
  final String content;
  final String author;
  final Uint8List image;
  final String ipfsAddress;
  final List<Comment> comments;
  final int lastId;
  final int likeCount;
  final int point;
  final int createdAt;

  Post({
    this.id,
    this.content,
    this.author,
    this.image,
    this.ipfsAddress,
    this.comments,
    this.lastId,
    this.likeCount,
    this.point,
    this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        content = '',
        author = json['author'],
        image = null,
        ipfsAddress = json['ipfs_addr'],
        comments = json['cmt_rows'].map<Comment>((c) => Comment.fromJson(c)).toList(),
        lastId = json['last_id'],
        likeCount = json['like_cnt'],
        point = json['point'],
        createdAt = json['created_at'];

  Post copyWith({
    int id,
    String content,
    String author,
    Uint8List image,
    String ipfsAddress,
    List<Comment> comments,
    int lastId,
    int likeCount,
    int point,
    int createdAt,
  }) =>
      Post(
        id: id ?? this.id,
        content: content ?? this.content,
        author: author ?? this.author,
        image: image ?? this.image,
        ipfsAddress: ipfsAddress ?? this.ipfsAddress,
        comments: comments ?? this.comments,
        lastId: lastId ?? this.lastId,
        likeCount: likeCount ?? this.likeCount,
        point: point ?? this.point,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return 'Post{id: $id, content: $content, author: $author, image: $image, ipfsAddress: $ipfsAddress, comments: $comments, lastId: $lastId, likeCount: $likeCount, point: $point, createdAt: $createdAt}';
  }
}
