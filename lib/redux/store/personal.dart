import 'package:flutter/material.dart';
import 'package:puton/redux/store/post.dart';

class Personal {
  final bool isStaggered;
  final String id;
  final String username;
  final String profileImg;
  final int postCount;
  final List<Post> tiles;
  final bool isLoading;

  Personal({
    this.isStaggered,
    this.id,
    this.username,
    this.profileImg,
    this.postCount,
    this.tiles,
    this.isLoading,
  });

  Personal.init({
    this.id,
    this.username,
    this.profileImg,
    this.postCount,
  }) :
      this.isStaggered = true,
      this.isLoading = true,
      this.tiles = [];

  Personal copyWith({
    bool isStaggered,
    String id,
    String username,
    String profileImg,
    int postCount,
    List<Post> tiles,
    bool isLoading,
  }) =>
      Personal(
        isStaggered: isStaggered ?? this.isStaggered,
        id: id ?? this.id,
        username: username ?? this.username,
        profileImg: profileImg ?? this.profileImg,
        postCount: postCount ?? this.postCount,
        tiles: tiles ?? this.tiles,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  String toString() {
    return 'Personal{isStaggered: $isStaggered, id: $id, username: $username, profileImg: $profileImg, postCount: $postCount, tiles: $tiles, isLoading: $isLoading}';
  }

}
