import 'dart:io';

class Upload {
  final File imageFile;
  final String content;

  Upload({
    this.imageFile,
    this.content,
  });

  Upload.init({
    this.imageFile,
    this.content,
  });

  Upload copyWith({
    File imageFile,
    String content,
  }) =>
      Upload(
        imageFile: imageFile ?? this.imageFile,
        content: content ?? this.content,
      );

  @override
  String toString() {
    return 'Upload{imageFile: $imageFile, content: $content}';
  }

}
