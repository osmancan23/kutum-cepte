import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/model/marker_model.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/utils/extension/list_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
import 'package:flutter/services.dart';
part 'mixin/google_map_widget_mixin.dart';
part 'widget/full_screen_google_map.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    super.key,
    this.width,
    this.height,
    this.locations,
    this.onMapTap,
    this.currentLocation,
  });
  final void Function(LatLng location)? onMapTap;
  final double? width;
  final double? height;
  final List<MarkerModel>? locations;
  final MarkerModel? currentLocation;
  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> with _GoogleMapWidgetMixin {


  @override
  void didUpdateWidget(covariant GoogleMapWidget oldWidget) {
    _handleMarker(widget.locations);
    _handleCurentLocation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: context.border.lowBorderRadius,
              child: SizedBox(
                width: widget.width ?? context.sized.width,
                height: widget.height ?? 350.h,
                child: _buildMapContent(),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: _buildFullScreenButton(context),
            ),
          ],
        ),
        10.h.ph,
        _buildInfoText(
          context,
          '* Kırmızı Renkli İşaret Secili Dükkanı Gösterir.',
        ),
        _buildInfoText(
          context,
          '* Mavi Renkli İşaret İşlem Yapılmamış Dükkanı Gösterir.',
        ),
        _buildInfoText(
          context,
          '* Yeşil Renkli İşaret Tamamlanmış Dükkanı Gösterir.',
        ),
        _buildInfoText(
          context,
          '* Sarı Renkli İşaret Görev Atanmış Dükkanı Gösterir.',
        ),
      ],
    );
  }

  Widget _buildFullScreenButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(
          Icons.fullscreen,
          color: Colors.black87,
        ),
        onPressed: () => _openFullScreenMap(context),
      ),
    );
  }

 

  Widget _buildMapContent() {
    return ValueListenableBuilder(
      valueListenable: _isLoading,
      builder: (ctx, value, child) {
        return value
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                myLocationEnabled: true,
                markers: _markers.values.toSet(),
                initialCameraPosition: _lastCameraPosition ??
                    CameraPosition(
                      target: _currentPosition ?? const LatLng(0, 0),
                      zoom: _mapZoom,
                    ),
                gestureRecognizers: const {
                  Factory<OneSequenceGestureRecognizer>(
                    EagerGestureRecognizer.new,
                  ),
                },
                onMapCreated: (controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                  _mapController = controller;

                  if (_lastCameraPosition != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(_lastCameraPosition!),
                      );
                    });
                  }
                },
                onCameraMove: (position) {
                  _lastCameraPosition = position;
                },
                onTap: (location) {
                  if (widget.onMapTap != null) {
                    _addMarker(
                      MarkerModel(
                        id: 'add_marker',
                        latitude: location.latitude,
                        longitude: location.longitude,
                        markerType: MarkerType.selected,
                      ),
                    );
                  }
                  widget.onMapTap?.call(location);
                },
              );
      },
    );
  }

  Row _buildInfoText(BuildContext context, String? text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text,
          textStyle: context.general.textTheme.bodySmall?.copyWith(
            fontSize: 9.sp,
            color: context.general.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
