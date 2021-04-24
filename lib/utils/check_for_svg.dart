


 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget isImageSVG(String image) {
    if (image.contains("svg")) {
      return SvgPicture.network(
                        image,
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const CircularProgressIndicator()),
                      );
    } else {
      return Image.network(image);
    }
  }


