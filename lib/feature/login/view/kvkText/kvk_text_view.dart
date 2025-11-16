import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/feature/login/view/kvkText/viewModel/kvk_text_view_model.dart';

@RoutePage()
class KvkTextView extends StatelessWidget {
  const KvkTextView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: KvkTextViewModel(),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: 'KVK Metini',
          body: SingleChildScrollView(
            child: Padding(
              padding: context.padding.low,
              child: HtmlWidget(
                viewModel.kvkHtmlText ?? '',
                textStyle: context.general.textTheme.bodySmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
