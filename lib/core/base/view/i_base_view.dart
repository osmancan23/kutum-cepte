import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart' show IBaseViewModel;
import 'package:kutum_cepte_app/core/components/loading/loading_widget.dart';
import 'package:stacked/stacked.dart';

@immutable
final class IBaseView<T extends IBaseViewModel> extends StatelessWidget {
  const IBaseView({
    required this.viewModel,
    required this.builder,
    super.key,
    this.onModelReady,
  });

  final Widget Function(T model) builder;
  final T viewModel;
  final dynamic Function(T? model)? onModelReady;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>.reactive(
      disposeViewModel: false,
      onDispose: (T viewModel) => viewModel.reset(),
      viewModelBuilder: () => viewModel,
      builder: (_, T viewModel, __) => Stack(
        children: [
          builder(viewModel),
          if (viewModel.isLoading) const LoadingWidget(isLoading: true),
        ],
      ),
      onViewModelReady: (T viewModel) async {
        if (onModelReady == null) {
          viewModel.setContext(context);
          await viewModel.init();
        } else {
          await onModelReady!(viewModel);
        }
      },
    );
  }
}
