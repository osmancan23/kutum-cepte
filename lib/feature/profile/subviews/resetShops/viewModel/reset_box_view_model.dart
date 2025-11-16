import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:flutter/material.dart';

class ResetBoxViewModel extends IBaseViewModel {
  late ShopBloc shopBloc;
  int selectedSehirId = 0;
  BuildContext? context;

  @override
  Future<void> init() async {
    shopBloc = BlocProvider.of<ShopBloc>(context!);

    // Listen to ShopBloc state changes
    shopBloc.stream.listen((state) {
      if (state is ShopResetted) {
        snackbarWidget(
          context as BuildContext,
          message: 'Kutular resetlendi.',
        );
      }
    });

    shopBloc.add(ResetShops(sehirId: selectedSehirId));
    return Future.value();
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}
