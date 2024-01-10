import 'package:client_swift/Unit/Url.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  String image;
  double? height;
  double? width;
  BoxFit? fit;

  ImageWidget(
      {super.key, this.height, this.width, required this.image, this.fit});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      unitUrl.imageUrl(widget.image),
      errorBuilder: ((context, error, stackTrace) => const SizedBox()),
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
    );
  }
}
