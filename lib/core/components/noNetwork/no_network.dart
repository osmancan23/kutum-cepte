import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_result_enums.dart';
import 'package:kutum_cepte_app/core/init/network/network_change_manager.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget>
    with TickerProviderStateMixin {
  // late final INetworkChangeManager _networkChange;
  // NetworkResultEnums? _networkResult;

  @override
  void initState() {
    super.initState();

    // _networkChange = NetworkChangeManager();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _networkChange.handleNetworkChange(_updateView);
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final result = await _networkChange.checkNetworkFirstTime();
      // _updateView(result);
    });
  }

  // void _updateView(NetworkResultEnums result) {
  //   setState(() {
  //     _networkResult = result;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration.zero,
      crossFadeState: CrossFadeState.showSecond,

      //  _networkResult == NetworkResultEnums.off ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Material(
        child: SizedBox(
          height: context.sized.height,
          width: context.sized.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText('No Network'),
            ],
          ),
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
