import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  const CacheNetworkImageWidget({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: 30.r,
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
