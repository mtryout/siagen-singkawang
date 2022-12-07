import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'custom_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxFit? fit;
  final bool? isCanZoom;

  const CustomNetworkImage(
      {Key? key,
      this.url,
      this.height,
      this.width,
      this.borderRadius = 0,
      this.fit = BoxFit.cover,
      this.isCanZoom = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget customPhoto(double? heightx, double? widthx, BoxFit? fitx) {
      return CachedNetworkImage(
        imageUrl: url!,
        placeholder: (context, url) => const CustomLoading(
          color: Colors.green,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        height: heightx,
        width: widthx,
        fit: fitx,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!),
      child: InkWell(
          onTap: () {
            if (isCanZoom!) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            backgroundColor: Colors.black,
                            appBar: AppBar(
                              backgroundColor: Colors.black,
                              elevation: 0,
                            ),
                            body: Center(
                              child: PhotoView(
                                  imageProvider: CachedNetworkImageProvider(
                                url!,
                              )),
                            ),
                          )));
            }
          },
          child: customPhoto(height, width, BoxFit.cover)),
    );
  }
}
