import 'dart:io';

import 'package:puton/redux/store/personal.dart';
import 'package:puton/redux/store/upload.dart';
import 'package:redux/redux.dart';

class SetImageFileAction {
  final File imageFile;

  SetImageFileAction(this.imageFile);
}

class SetContentAction {
  final String content;

  SetContentAction(this.content);
}

class SavePostAction {}

class ClearUploadFormAction {}

Upload _clearUpload(Upload upload, ClearUploadFormAction action) =>
    Upload.init();

Upload _setImageFile(Upload upload, SetImageFileAction action) =>
    upload.copyWith(imageFile: action.imageFile);

Upload _setContent(Upload upload, SetContentAction action) =>
    upload.copyWith(content: action.content);

//Upload _savePost(Upload upload, SetImageFileAction action) =>
//    upload.copyWith(content: action.);


final Reducer<Upload> uploadReducer = combineReducers<Upload>([
  TypedReducer<Upload, ClearUploadFormAction>(_clearUpload),
  TypedReducer<Upload, SetImageFileAction>(_setImageFile),
  TypedReducer<Upload, SetContentAction>(_setContent),
//  TypedReducer<Upload, SavePostAction>(_savePost),
]);
