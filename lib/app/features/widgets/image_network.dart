import 'package:flutter/material.dart';
class ImageNetwork extends StatelessWidget {
  const ImageNetwork(this.pictureUrl, {this.fit = BoxFit.fitHeight, Key? key})
      : super(key: key);

  final String pictureUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pictureUrl,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      fit: fit,
    );
  }
}
