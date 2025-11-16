import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/box_status_enum.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/address_drop_down_widget.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@RoutePage()
class ShopListView extends StatefulWidget {
  const ShopListView({super.key});

  @override
  State<ShopListView> createState() => _ShopListViewState();
}

class _ShopListViewState extends State<ShopListView> {
  final TextEditingController _searchController = TextEditingController();
  final AddressBloc _cityBloc = AddressBloc(locator<AddressService>());
  final AddressBloc _districtBloc = AddressBloc(locator<AddressService>());
  final ShopService _shopService = ShopService();

  AddressModel? _selectedCity;
  AddressModel? _selectedDistrict;
  List<ShopModel> _shops = [];
  List<ShopModel> _filteredShops = [];

  @override
  void initState() {
    super.initState();
    _cityBloc.add(FetchCities());
  }

  void _filterShops(String query) {
    setState(() {
      _filteredShops = _shops
          .where(
            (shop) => shop.title?.toLowerCase().contains(query.toLowerCase()) ?? false,
          )
          .toList();
    });
  }

  Future<void> _fetchShops() async {
    if (_selectedCity != null && _selectedDistrict != null) {
      final shops = await _shopService.fetchAllShops(
        sehirId: _selectedCity!.id ?? 0,
        ilceId: _selectedDistrict!.id ?? 0,
      );
      setState(() {
        _shops = shops;
        _filteredShops = shops;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbarTitle: 'Dükkan Listesi',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            16.h.ph,
            AddressDropDownButtonWidget(
              addressBloc: _cityBloc,
              type: AddressDropDownType.city,
              onChange: (value) {
                setState(() {
                  _selectedCity = value;
                  _selectedDistrict = null;
                });
                if (_selectedCity != null) {
                  _districtBloc.add(FetchDistricts(cityId: value!.id!));
                }
              },
            ),
            16.h.ph,
            AddressDropDownButtonWidget(
              addressBloc: _districtBloc,
              type: AddressDropDownType.district,
              onChange: (value) {
                setState(() {
                  _selectedDistrict = value;
                });
                _fetchShops();
              },
            ),
            16.h.ph,
            TextFormFieldWidget(
              textEditingController: _searchController,
              hintText: 'Dükkan Ara...',
              prefixIcon: IconEnums.search,
              onChange: _filterShops,
            ),
            16.h.ph,
            SizedBox(
              height: 500.h,
              child: ListView.builder(
                itemCount: _filteredShops.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final shop = _filteredShops[index];
                  return Padding(
                    padding: context.padding.verticalLow,
                    child: _ShopListTile(shop: shop),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cityBloc.close();
    _districtBloc.close();
    super.dispose();
  }
}

class _ShopListTile extends StatelessWidget {
  const _ShopListTile({
    required this.shop,
  });

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(ShopDetailRoute(shopId: shop.id!)),
      child: Container(
        height: 85.h,
        decoration: BoxDecoration(
          color: context.general.colorScheme.primary.withOpacity(0.1),
          borderRadius: context.border.normalBorderRadius,
          boxShadow: context.getBoxShadow,
        ),
        child: Padding(
          padding: context.padding.normal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    shop.title,
                    textStyle: context.general.textTheme.bodyLarge?.copyWith(
                      color: context.general.colorScheme.primary,
                    ),
                  ),
                  CustomText(
                    'Kutu Durumu: ${BoxStatusEnum.values.where((e) => e.value == shop.boxStatus).first.title} - Shop No: ${shop.shopNo}',
                    textStyle: context.general.textTheme.bodySmall?.copyWith(),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_circle_right,
                color: context.general.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
