import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget networkImage(String imageUrl,
        {boxFit = BoxFit.cover, double? width, double? height}) =>
    CachedNetworkImage(
      fit: boxFit,
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          SizedBox(
                width: 200.0,
                height: 100.0,
                child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child:const Text(
                            'Shimmer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight:
                                  FontWeight.bold,
                            ),
                      ),
                ),
          ),
      errorWidget: (context, url, error) =>
          Image.asset('assets/img/image_default.png', fit: BoxFit.cover),
    );
