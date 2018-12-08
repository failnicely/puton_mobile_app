import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:puton/redux/store/img.dart';
import 'package:puton/redux/store/post.dart';
import 'package:puton/widget/shared/example_tile.dart';

Future<List<String>> listUsername() async {
  final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};
  final body = Map();
  body.putIfAbsent('json', () => 'true');
  body.putIfAbsent('table', () => 'users');
  body.putIfAbsent('scope', () => 'asas123fdfsa');
  body.putIfAbsent('code', () => 'asas123fdfsa');

  final response = await http.post(
    'http://dev.cryptolions.io:38888/v1/chain/get_table_rows',
    headers: headers,
    body: jsonEncode(body),
  );

  final json = jsonDecode(utf8.decode(response.bodyBytes));
  print('listUser');
  print(json);
  print(json['rows']);

  return json['rows']
      .map((u) => u['account'])
      .toList()
      .cast<String>();
}

//Future<Post> savePost(Post post) async {
//  final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};
//  final body = Map();
//  body.putIfAbsent('json', () => 'true');
//  body.putIfAbsent('table', () => 'posts');
//  body.putIfAbsent('scope', () => 'esgfijifdgdf');
//  body.putIfAbsent('code', () => 'esgfijifdgdf');
//
//  final response = await http.post(
//    'http://dev.cryptolions.io:38888/v1/chain/get_table_rows',
//    headers: headers,
//    body: jsonEncode(body),
//  );
//
//  final json = jsonDecode(utf8.decode(response.bodyBytes));
//  print(json);
//  print(json['rows']);
//
//  final List<Post> posts = json['rows'].map<Post>((p) => Post.fromJson(p)).toList();
//  return posts;
//}
