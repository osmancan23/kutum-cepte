import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/cacheNetworkImage/cache_network_image_widget.dart';

@RoutePage()
class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView({required this.url, super.key});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            context.router.back();
          }
        },
        child: Center(
          child: SizedBox(
            height: context.sized.dynamicHeight(1),
            width: context.sized.dynamicWidth(1),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: context.sized.dynamicHeight(0.6),
                    width: context.sized.dynamicWidth(1),
                    child: CacheNetworkImageWidget(
                      imageUrl: url,
                    ),
                  ),
                ),
                const _CloseButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CloseButtonWidget extends StatelessWidget {
  const _CloseButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100.h,
      right: 10.w,
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
          size: 30.w,
        ),
        onPressed: () {
          context.router.back();
        },
      ),
    );
  }
}
