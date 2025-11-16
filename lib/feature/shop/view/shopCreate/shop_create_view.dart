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
import 'package:kutum_cepte_app/core/components/textFormField/phone_input_formatter.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/liveTracking/widget/select_location_widget.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/address_drop_down_widget.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';

import 'package:kutum_cepte_app/feature/shop/view/shopCreate/viewModel/shop_create_view_model.dart';
import 'package:kutum_cepte_app/product/widget/googleMap/google_map_widget.dart';
import 'package:kutum_cepte_app/product/widget/imageBox/image_box_widget.dart';
import 'package:kutum_cepte_app/utils/extension/list_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part 'widget/shop_create_images_widget.dart';

@RoutePage()
class ShopCreateView extends StatelessWidget {
  const ShopCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: ShopCreateViewModel(),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: 'Yeni Dükkan Ekle',
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormFieldWidget(
                        hintText: 'Dükkan Adı',
                        onSaved: (value) => viewModel.shopName = value,
                      ),
                      10.h.ph,
                      AddressDropDownButtonWidget(
                        onChange: (address) {
                          viewModel.cityId = address?.id;
                          viewModel.districtBloc.add(FetchDistricts(cityId: viewModel.cityId!));
                          viewModel.cityName = address?.title;
                        },
                        addressBloc: viewModel.cityBloc,
                        type: AddressDropDownType.city,
                      ),
                      10.h.ph,
                      AddressDropDownButtonWidget(
                        onChange: (address) {
                          viewModel
                            ..districtId = address?.id
                            ..districtName = address?.title;
                          if (viewModel.cityId != null && viewModel.districtId != null) {
                            viewModel.shopBloc
                                .add(FetchAllShops(sehirId: viewModel.cityId!, ilceId: viewModel.districtId!));
                          }
                        },
                        addressBloc: viewModel.districtBloc,
                        type: AddressDropDownType.district,
                      ),

                      // 10.h.ph,
                      // AddressDropDownButtonWidget(
                      //   onChange: (address) {
                      //     viewModel.neighborhoodId = address?.id;
                      //   },
                      //   addressBloc: viewModel.neighborhoodBloc,
                      //   type: AddressDropDownType.neighborhood,
                      // ),

                      10.h.ph,

                      TextFormFieldWidget(
                        hintText: 'Dükkan Adresi',
                        maxLines: 3,
                        onSaved: (value) => viewModel.shopAddress = value,
                      ),
                      TextFormFieldWidget(
                        hintText: 'Kutu Sayısı:(Default 1)',
                        textInputType: TextInputType.number,
                        onSaved: (value) => value != null ? viewModel.boxCount = int.tryParse(value) : null,
                      ),
                    ],
                  ),
                ),
                10.h.ph,
                _ShopCreateImagesWidget(viewModel),
                20.h.ph,
                const SelectLocationWidget(
                  clickType: SelectLocationClickType.off,
                ),
                20.h.ph,
                GoogleMapWidget(
                  currentLocation: viewModel.locations.getListItem(0),
                  onMapTap: (location) {
                    viewModel
                      ..latitude = location.latitude
                      ..longitude = location.longitude;
                  },
                  height: 450.h,
                ),
                20.h.ph,
                ButtonWidget(
                  onTap: () => viewModel.createShop(),
                  text: 'Yeni Kutu Ekle',
                  disabled: viewModel.isLoading,
                ),
                40.h.ph,
              ],
            ),
          ),
        );
      },
    );
  }
}
