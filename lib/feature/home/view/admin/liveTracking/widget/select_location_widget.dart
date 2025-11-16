import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';

enum SelectLocationClickType { on, off }

class SelectLocationWidget extends StatefulWidget {
  const SelectLocationWidget({this.clickType = SelectLocationClickType.on, super.key, this.onSelect});
  final SelectLocationClickType clickType;
  final void Function(int? cityId, int? districtId)? onSelect;
  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}

class _SelectLocationWidgetState extends State<SelectLocationWidget> {
  late AddressBloc _cityBloc;
  late AddressBloc _districtBloc;
  String? selectedCity;

  String? selectedDistrict;
  int? cityId;
  int? districtId;

  @override
  void initState() {
    _cityBloc = AddressBloc(locator<AddressService>());
    _districtBloc = AddressBloc(locator<AddressService>());
    _cityBloc.add(FetchCities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => widget.clickType == SelectLocationClickType.on ? await _openBottomSheet(context) : null,
      child: Container(
        width: 380.w,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: context.border.lowBorderRadius,
          color: context.general.colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                selectedCity != null && selectedDistrict != null ? '$selectedCity/$selectedDistrict' : 'Lokasyon Seç',
                textStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: context.general.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SvgPicture.asset(IconEnums.location.svgPathIcon),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openBottomSheet(BuildContext context) async {
    await showBottomSheetWidget(
      context,
      body: BlocBuilder<AddressBloc, AddressState>(
        bloc: _cityBloc,
        builder: (context, state) {
          if (state is AddressCompleted) {
            return _BottomSheetContent(
              list: state.addressList.map((e) => e.title!).toList(),
              onSelect: (value) {
                cityId = state.addressList.firstWhere((element) => element.title == value).id;
                selectedCity = value;
                _districtBloc.add(
                  FetchDistricts(
                    cityId: cityId!,
                  ),
                );
                widget.onSelect?.call(
                  cityId,
                  districtId,
                );
                setState(() {});
              },
            );
          } else if (state is AddressError) {
            return const Center(
              child: CustomText('Bir sorun oluştu'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ).then((_) async {
      if (context.mounted) {
        await showBottomSheetWidget(
          context,
          body: BlocBuilder<AddressBloc, AddressState>(
            bloc: _districtBloc,
            builder: (context, state) {
              if (state is AddressCompleted) {
                return _BottomSheetContent(
                  list: state.addressList.map((e) => e.title!).toList(),
                  onSelect: (value) {
                    districtId = state.addressList.firstWhere((element) => element.title == value).id;
                    selectedDistrict = value;
                    widget.onSelect?.call(
                      cityId,
                      districtId,
                    );
                    setState(() {});
                  },
                );
              } else if (state is AddressError) {
                return const Center(
                  child: CustomText('Bir sorun oluştu'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }
    });
  }
}

final class _BottomSheetContent extends StatefulWidget {
  const _BottomSheetContent({required this.list, this.onSelect});
  final List<String> list;
  final void Function(String value)? onSelect;

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      padding: context.padding.normal,
      child: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return RadioListTile<String>(
            title: CustomText(
              widget.list[index],
              textStyle: context.general.textTheme.bodyMedium,
            ),
            value: widget.list[index],
            groupValue: selectedCity,
            onChanged: (String? value) async {
              setState(() {
                selectedCity = value;
              });
              widget.onSelect?.call(value!);
              await Future.delayed(Durations.medium1, () {
                if (context.mounted) {
                  context.closePopup();
                }
              });
            },
          );
        },
      ),
    );
  }
}
