import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/style.dart';
import 'package:puton/db/db_helper.dart';
import 'package:puton/redux/reducer/index.dart';
import 'package:puton/redux/reducer/upload.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/widget/shared/app_bar.dart';
import 'package:image_picker/image_picker.dart';


class UploadPostScreen extends StatelessWidget {
  static const platform = const MethodChannel('puton.failnicely.com/nova');

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: EmptyAppBar(color: PColor.white),
        body: Builder(
          builder: (context) =>
              Container(
                color: PColor.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    Container(color: PColor.gray5, height: 0.5),
                    _buildContentBox(context),
//            Container(color: PColor.gray6, height: 0.5),
//            _buildListItem('이름', 'PRETYCUL'),
//            Container(color: PColor.gray6, height: 0.5),
//            _buildListItem('사용자 이름', 'pretycul'),
//            Container(color: PColor.gray6, height: 0.5),
//            _buildListItem('웹사이트', ''),
//            Container(color: PColor.gray6, height: 0.5),
//            _buildListItem('소개', 'hello :)'),
//            Container(color: PColor.gray6, height: 0.5),
                    Flexible(flex: 1, child: Container(color: PColor.white)),
                  ],
                ),
              ),
        ),
      );

  Widget _buildContentBox(context) =>
      StoreConnector<AppState, File>(
        onInit: (_) => _init(),
        converter: (store) => store.state.upload.imageFile,
        builder: (context, File image) =>
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(image),
                    Container(width: 12),
                    Flexible(flex: 1, child: _buildText(image)),
                  ]
              ),
            )
      );

  Widget _buildImage(File image) =>
      InkWell(
          onTap: () => _getImage(),
          child: Container(
              decoration: _buildImageBoxDecoration(),
              child: image == null
                  ? Container(width: 80, height: 80, decoration: _buildImageBoxDecoration())
                  : Image.file(image, width: 80, height: 80)
          )
      );

  BoxDecoration _buildImageBoxDecoration() =>
      BoxDecoration(
        color: PColor.gray6,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      );

  Widget _buildText(File image) =>
      Container(
          child: TextField(
            onChanged: (text) => store.dispatch(SetContentAction(text)),
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration.collapsed(
              hintStyle: PStyle.formHint,
              hintText: '설명 입력...',
            ),
          )
      );

  Widget _buildHeader(context) =>
      Container(
        color: PColor.white,
        height: 45,
        child: Stack(
          children: [
            Container(
                height: 45,
                child: Center(child: Text('New Post', style: PStyle.appBarTitle))
            ),
            Row(
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Image.asset('image/icon/arrow_black.png', width: 9, height: 15),
                ),
                Flexible(flex: 1, child: Container()),
                MaterialButton(
                  onPressed: () => _savePost(context),
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text('Done', style: PStyle.appBarDone),
                ),
              ],
            ),
          ],
        ),
      );

  Future _init() async {
    store.dispatch(ClearUploadFormAction());
    await _getImage();
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    store.dispatch(SetImageFileAction(image));
  }

  void _savePost(context) async {
    final upload = store.state.upload;
    final imageFile = upload.imageFile;

    if (upload.imageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('이미지를 등록해주세요')));
      return;
    }

    final user = (await DBHelper().getUsers())[0];
    final username = user.username;
    final imageBase64 = imageFile != null ? base64Encode(imageFile.readAsBytesSync()) : '';
    final content = upload.content;

    print('_savePost');
    final payload = {'imageBase64': imageBase64, 'content': content};
    String ipfsHash = await platform.invokeMethod('saveIpfsMethod', {'payload': jsonEncode(payload)});

    var params = {'ipfsHash': ipfsHash, 'username': username};
    String result = await platform.invokeMethod('savePostMethod', params);
    print('_savePost result');
    print(result);

    Navigator.pop(context);
  }
}
