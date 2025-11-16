part of '../google_map_widget.dart';

class _FullScreenMapView extends StatefulWidget {
  const _FullScreenMapView({
    required this.markers,
    this.locations,
    this.currentLocation,
    this.initialPosition,
    this.initialCameraPosition,
    this.onMapTap,
  });

  final List<MarkerModel>? locations;
  final MarkerModel? currentLocation;
  final LatLng? initialPosition;
  final CameraPosition? initialCameraPosition;
  final Map<MarkerId, Marker> markers;
  final void Function(LatLng location)? onMapTap;

  @override
  State<_FullScreenMapView> createState() => _FullScreenMapViewState();
}

class _FullScreenMapViewState extends State<_FullScreenMapView> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late Map<MarkerId, Marker> _markers;
  final double _mapZoom = 17;
  GoogleMapController? _mapController;
  CameraPosition? _lastCameraPosition;

  @override
  void initState() {
    super.initState();
    _markers = Map.of(widget.markers);
    _lastCameraPosition = widget.initialCameraPosition;

    // Tam ekran modunda sistem UI'ını gizle
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Normal modda sistem UI'ını geri yükle
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _mapController?.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (val, res) async {
        // Çıkışta sistem UI'ını geri yükle
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

        // Kamera pozisyonunu kaydet
        await _saveCameraPosition();

        // Geri dönüşte markerları ve kamera pozisyonunu ana widget'a aktar
        if (context.mounted) {
          Navigator.of(context).pop({
            'markers': _markers,
            'cameraPosition': _lastCameraPosition,
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              markers: _markers.values.toSet(),
              initialCameraPosition: _lastCameraPosition ??
                  CameraPosition(
                    target: widget.initialPosition ?? const LatLng(0, 0),
                    zoom: _mapZoom,
                  ),
              onMapCreated: (controller) {
                _controller.complete(controller);
                _mapController = controller;

                // Eğer kaydedilmiş bir kamera pozisyonu varsa, harita oluşturulduktan sonra o pozisyona git
                if (_lastCameraPosition != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(_lastCameraPosition!),
                    );
                  });
                }
              },
              onCameraMove: (position) {
                // Kamera hareket ettiğinde, mevcut pozisyonu kaydet
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
                  widget.onMapTap?.call(location);
                }
              },
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: _buildBackButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
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
          Icons.arrow_back,
          color: Colors.black87,
        ),
        onPressed: () async {
          // Kamera pozisyonunu kaydet
          await _saveCameraPosition();

          // Geri dönüşte markerları ve kamera pozisyonunu ana widget'a aktar
          if (context.mounted) {
            Navigator.of(context).pop({
              'markers': _markers,
              'cameraPosition': _lastCameraPosition,
            });
          }
        },
      ),
    );
  }

  Future<void> _addMarker(MarkerModel? location) async {
    if (location == null) return;

    // İkon renkleri için basit bir harita

    // İkonu oluştur
    final icon = await _createCustomMarkerIcon(location.markerType.color);

    // Marker oluştur
    final marker = Marker(
      markerId: MarkerId(location.id.toString()),
      position: LatLng(location.latitude!, location.longitude!),
      icon: icon,
      infoWindow: InfoWindow(
        title: location.title,
        onTap: () {
          if (location.id != null) {
            context.router.push(
              ShopDetailRoute(
                shopId: int.parse(location.id!),
                taskId: location.taskId,
              ),
            );
          }
        },
      ),
    );

    setState(() {
      _markers[marker.markerId] = marker;
    });
  }

  Future<BitmapDescriptor> _createCustomMarkerIcon(Color color) async {
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
}
