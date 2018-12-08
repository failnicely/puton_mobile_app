import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:puton/redux/store/post.dart';

Future<List<Post>> fetchPost() async {
  final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};
  final body = Map();
  body.putIfAbsent('json', () => 'true');
  body.putIfAbsent('table', () => 'posts');
  body.putIfAbsent('scope', () => 'asas123fdfsa');
  body.putIfAbsent('code', () => 'asas123fdfsa');
  body.putIfAbsent('limit', () => 20);

  final response = await http.post(
    'http://dev.cryptolions.io:38888/v1/chain/get_table_rows',
    headers: headers,
    body: jsonEncode(body),
  );

  final json = jsonDecode(utf8.decode(response.bodyBytes));
  print(json['rows']);

  List<Post> results = await Future.wait<Post>(
      json['rows']
          .map((p) => Post.fromJson(p))
          .where((p) => p.id > 8 && p.id != 11)
          .where((p) => p.ipfsAddress.startsWith('Q') as bool)
          .map(_fetchIpfs)
          .toList()
          .cast<Future<Post>>()
  );
  results.sort((p1, p2) => p2.createdAt - p1.createdAt);

  return results;
}

Future<Post> _fetchIpfs(p) async {
  var post = p as Post;
  print('http://52.79.151.139:8080/ipfs/${post.ipfsAddress}');
  final response = await http.get('http://52.79.151.139:8080/ipfs/${post.ipfsAddress}');
  final json = jsonDecode(utf8.decode(response.bodyBytes));
  print('http://52.79.151.139:8080/ipfs/${post.ipfsAddress} : ${json['content']}'); //todo: 자체 노드에서 가져와야??
  return post.copyWith(
    content: json['content'],
    image: base64Decode(json['imageBase64']),
  );
}
