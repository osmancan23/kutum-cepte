import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/components/dropdownButtonWidget/dropdown_button_widget.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';

enum AddressDropDownType {
  city,
  district;
  

  String get title {
    switch (this) {
      case AddressDropDownType.city:
        return 'Şehir';
      case AddressDropDownType.district:
        return 'İlçe';
    }
  }
}

class AddressDropDownButtonWidget extends StatelessWidget {
  const AddressDropDownButtonWidget({
    required this.onChange,
    required this.addressBloc,
    required this.type,
    super.key,
    this.initialAddress,
    this.title,
    this.validator,
  });
  final void Function(AddressModel? value) onChange;
  final AddressBloc addressBloc;
  final AddressDropDownType type;
  final String? initialAddress;
  final String? title;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      bloc: addressBloc,
      builder: (context, state) {
        if (state is AddressCompleted) {
          return DropdownButtonWidget(
            title: title,
            options: state.addressList.map((e) => e.title ?? '').toList(),
            hintText: '${type.title} Seçiniz',
            value: initialAddress,
            validator: validator,
            onChange: (value) {
              onChange(state.addressList.firstWhere((element) => element.title == value));
            },
          );
        } else if (state is AddressError) {
          return Center(child: CustomText('${type.title}ler yüklenirken bir hata oluştu.'));
        } else if (state is AddressLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return DropdownButtonWidget(
          options: initialAddress != null ? [initialAddress!] : ['${type.title} Seçiniz'],
          hintText: '${type.title} Seçiniz',
          value: initialAddress,
          title: title,
        );
      },
    );
  }
}
