import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/dropdownButtonWidget/dropdown_button_widget.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/resetShops/viewModel/reset_box_view_model.dart';

@RoutePage()
class ResetBoxesView extends StatefulWidget {
  const ResetBoxesView({super.key});

  @override
  _ResetBoxesViewState createState() => _ResetBoxesViewState();
}

class _ResetBoxesViewState extends State<ResetBoxesView> {
  late ResetBoxViewModel viewModel;
  int? selectedSehirId;
  final List<int> sehirIds = [1, 2, 3, 4]; // Şehir ID'lerini buraya ekleyin
  final Map<int, String> sehirNames = {
    1: 'İstanbul',
    2: 'Ankara',
    3: 'İzmir',
    4: 'Mersin',
  };

  @override
  void initState() {
    super.initState();
    viewModel = ResetBoxViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: viewModel,
      builder: (context) {
        return ScaffoldWidget(
          appbarTitle: 'Kutuları Resetle',
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'Şehir Seçin',
                ),
                const SizedBox(height: 10),
                DropdownButtonWidget(
                  options: sehirIds.map((id) => sehirNames[id]!).toList(),
                  hintText: 'Şehir Seçin',
                  value: selectedSehirId != null ? sehirNames[selectedSehirId] : null,
                  onChange: (String? newValue) {
                    setState(() {
                      selectedSehirId = sehirNames.entries.firstWhere((entry) => entry.value == newValue).key;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  text: 'Reset Shops',
                  onTap: selectedSehirId != null
                      ? () {
                          viewModel.selectedSehirId = selectedSehirId!;
                          viewModel.init();
                        }
                      : () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
