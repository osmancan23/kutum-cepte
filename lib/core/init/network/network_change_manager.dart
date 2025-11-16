// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:kutum_cepte_app/core/constants/enums/network_result_enums.dart';

// typedef NetworkCallBack = void Function(NetworkResultEnums result);

// abstract class INetworkChangeManager {
//   Future<NetworkResultEnums> checkNetworkFirstTime();
//   void handleNetworkChange(NetworkCallBack onChange);
//   void dispose();
// }

// class NetworkChangeManager extends INetworkChangeManager {
//   NetworkChangeManager() {
//     _connectivity = Connectivity();
//   }
//   late final Connectivity _connectivity;
//   StreamSubscription<List<ConnectivityResult>>? _subscription;

//   @override
//   Future<NetworkResultEnums> checkNetworkFirstTime() async {
//     final connectivityResult = await _connectivity.checkConnectivity();
//     return checkConnectivityResult(connectivityResult);
//   }

//   @override
//   void handleNetworkChange(NetworkCallBack onChange) {
//     _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
//       onChange.call(checkConnectivityResult(result));
//     });
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel();
//   }
// }
