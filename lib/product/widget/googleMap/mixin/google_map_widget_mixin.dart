part of '../google_map_widget.dart';

mixin _GoogleMapWidgetMixin on State<GoogleMapWidget> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Map<String, BitmapDescriptor> _markerIcons = {};

  LatLng? _currentPosition;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);

  Map<MarkerId, Marker> get markers => _markers;

  set markers(Map<MarkerId, Marker> value) {
    _markers.addAll(value);
  }

  LatLng? get currentPosition => _currentPosition;

  set currentPosition(LatLng? value) {
    _currentPosition = value;
  }

  final double _mapZoom = 17;

  GoogleMapController? _mapController;

  CameraPosition? _lastCameraPosition;

  @override
  void initState() {
    super.initState();
    _preloadMarkerIcons();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.locations.ext.isNotNullOrEmpty) {
        await _handleMarker(widget.locations);
        _isLoading.value = false;
      } else {
        await getLocation();
      }
    });
  }

  Future<void> _preloadMarkerIcons() async {
    // Tüm marker tiplerinin ikonlarını önceden yükle
    const markerTypes = MarkerType.values;
    for (final type in markerTypes) {
      final icon = await _resizeMarkerIcon(type.color);
      _markerIcons[type.toString()] = icon;
    }
  }

  Future<void> _handleMarker(List<MarkerModel>? locations) async {
    if (locations.ext.isNotNullOrEmpty) {
      try {
        if (_controller.isCompleted) {
          final controller = await _controller.future;
          await controller.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(
                locations!.getListItem(0)!.latitude!,
                locations.getListItem(0)!.longitude!,
              ),
            ),
          );
        }

        _markers.clear();

        // Tüm marker'ları tek seferde oluştur
        final newMarkers = await Future.wait(
          locations!.map(_createMarker),
        );

        if (mounted) {
          setState(() {
            for (final marker in newMarkers) {
              if (marker != null) {
                _markers[marker.markerId] = marker;
              }
            }
          });
        }
      } catch (e) {
        log('Marker işlenirken hata: $e');
      }
    }
  }

  Future<Marker?> _createMarker(MarkerModel? location) async {
    if (location == null) return null;

    final icon = _markerIcons[location.markerType.toString()] ?? await _resizeMarkerIcon(location.markerType.color);

    return Marker(
      markerId: MarkerId(location.id.toString()),
      icon: icon,
      position: LatLng(
        location.latitude!,
        location.longitude!,
      ),
      infoWindow: InfoWindow(
        title: location.title,
        onTap: () => context.router.push(
          ShopDetailRoute(
            shopId: int.parse(location.id!),
            taskId: location.taskId,
          ),
        ),
      ),
    );
  }

  /// MARK: Get current location
  Future<void> getLocation() async {
    try {
      await Geolocator.requestPermission();

      final position = await Geolocator.getCurrentPosition();
      final lat = position.latitude;
      final long = position.longitude;

      final location = LatLng(lat, long);

      if (mounted) {
        setState(() {
          _currentPosition = location;
        });
        _isLoading.value = false;
      }
    } catch (e) {
      log('Konum alınırken hata: $e');
      _isLoading.value = false;
    }
  }

  /// MARK: Add marker to map
  Future<void> _addMarker(MarkerModel? location) async {
    final marker = await _createMarker(location);
    if (marker != null && mounted) {
      setState(() {
        _markers[marker.markerId] = marker;
      });
    }
  }

  Future<void> _handleCurentLocation() async {
    if (widget.currentLocation != null) {
      setState(() {
        _currentPosition = LatLng(
          widget.currentLocation!.latitude!,
          widget.currentLocation!.longitude!,
        );
      });
      _isLoading.value = false;

      try {
        if (_controller.isCompleted) {
          final controller = await _controller.future;
          await controller.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(currentPosition!.latitude, currentPosition!.longitude),
            ),
          );
        }
      } catch (e) {
        log('Mevcut konum işlenirken hata: $e');
      }
    }
  }

  Future<BitmapDescriptor> _resizeMarkerIcon(Color color) async {
    const width = 80;
    const height = 80;

    final data = await DefaultAssetBundle.of(context).load('assets/icons/ic_marker.png');
    final bytes = data.buffer.asUint8List();

    final codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: width,
      targetHeight: height,
    );
    final frameInfo = await codec.getNextFrame();

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);

    final rect = Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());
    canvas.drawImageRect(frameInfo.image, rect, rect, paint);

    final coloredImage = await pictureRecorder.endRecording().toImage(width, height);
    final coloredBytes = await coloredImage.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(coloredBytes!.buffer.asUint8List());
  }

  Future<void> _openFullScreenMap(BuildContext context) async {
    // Tam ekrana geçmeden önce mevcut kamera pozisyonunu kaydet
    await _saveCameraPosition();
    if (context.mounted) {
      final result = await Navigator.of(context).push(
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => _FullScreenMapView(
            locations: widget.locations,
            currentLocation: widget.currentLocation,
            initialPosition: _currentPosition,
            initialCameraPosition: _lastCameraPosition,
            markers: Map.of(_markers),
            onMapTap: widget.onMapTap,
          ),
        ),
      );
      // Tam ekran sayfasından döndüğünde, eklenen markerları ve kamera pozisyonunu güncelle
      if (result != null && result is Map<String, dynamic>) {
        if (result.containsKey('markers') && result['markers'] is Map<MarkerId, Marker>) {
          setState(() {
            _markers
              ..clear()
              ..addAll(result['markers'] as Map<MarkerId, Marker>);
          });
        }

        if (result.containsKey('cameraPosition') && result['cameraPosition'] is CameraPosition) {
          _lastCameraPosition = result['cameraPosition'] as CameraPosition;

          // Harita denetleyicisi varsa, kamera pozisyonunu güncelle
          if (_mapController != null) {
            try {
              await _mapController!.animateCamera(
                CameraUpdate.newCameraPosition(_lastCameraPosition!),
              );
            } catch (e) {
              log('Küçük haritada kamera pozisyonu güncellenirken hata: $e');
            }
          }
        }
      }
    }
  }

  Future<void> _saveCameraPosition() async {
    if (_mapController != null) {
      try {
        final position = await _mapController!.getLatLng(
          const ScreenCoordinate(x: 0, y: 0),
        );
        final zoom = await _mapController!.getZoomLevel();
        _lastCameraPosition = CameraPosition(
          target: position,
          zoom: zoom,
        );
      } catch (e) {
        log('Kamera pozisyonu kaydedilirken hata: $e');
      }
    }
  }
}
