import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';

import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/address_drop_down_widget.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/view/shopEdit/viewModel/shop_edit_view_model.dart';
import 'package:kutum_cepte_app/product/widget/googleMap/google_map_widget.dart';
import 'package:kutum_cepte_app/product/widget/imageBox/image_box_widget.dart';
import 'package:kutum_cepte_app/utils/extension/list_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part 'widget/shop_edit_images_widget.dart';

@RoutePage()
class ShopEditView extends StatelessWidget {
  const ShopEditView({required this.shopModel, super.key});
  final ShopModel shopModel;
  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: ShopEditViewModel(shopModel),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: 'Dükkan Bilgisini Düzenle',
          body: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldWidget(
                  hintText: 'Dükkan Adı',
                  textEditingController: viewModel.shopNameController,
                ),
                TextFormFieldWidget(
                  hintText: 'Dükkan Sahibi',
                  textEditingController: viewModel.shopOwnerController,
                ),
                5.h.ph,
                AddressDropDownButtonWidget(
                  onChange: (address) {
                    viewModel.city = address;
                    viewModel.districtBloc.add(FetchDistricts(cityId: viewModel.city!.id!));
                    viewModel.district = null;
                  },
                  addressBloc: viewModel.cityBloc,
                  type: AddressDropDownType.city,
                  initialAddress: viewModel.city?.title,
                ),
                10.h.ph,
                AddressDropDownButtonWidget(
                  onChange: (address) {
                    viewModel.district = address;
                  },
                  addressBloc: viewModel.districtBloc,
                  type: AddressDropDownType.district,
                  initialAddress: viewModel.district?.title,
                ),
                10.h.ph,
                TextFormFieldWidget(
                  hintText: 'Kutu Sayısı',
                  initialValue: '${viewModel.boxCount}',
                  textInputType: TextInputType.number,
                  onSaved: (value) {
                    viewModel.boxCount = int.tryParse(value ?? '') ?? 0;
                  },
                ),
                TextFormFieldWidget(
                  hintText: 'Dükkan Adresi',
                  maxLines: 3,
                  textEditingController: viewModel.shopAddressController,
                ),
                10.h.ph,
                _ShopEditImagesWidget(
                  shopInitialImages: shopModel.shopPhotosUrl,
                  viewModel: viewModel,
                ),
                20.h.ph,
                GoogleMapWidget(
                  onMapTap: (location) {
                    viewModel
                      ..latitude = location.latitude
                      ..longitude = location.longitude;
                  },
                ),
                20.h.ph,
                ButtonWidget(onTap: () => viewModel.updateShop(), text: 'Güncelle'),
                40.h.ph,
              ],
            ),
          ),
        );
      },
    );
  }
}
