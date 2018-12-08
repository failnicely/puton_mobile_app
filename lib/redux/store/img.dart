
class Img {
  final String url;
  final int width;
  final int height;
  final double ratio;

  Img({
    this.url,
    this.width,
    this.height,
    this.ratio,
  });

  @override
  String toString() {
    return 'Img{url: $url, width: $width, height: $height, ratio: $ratio}';
  }
}
