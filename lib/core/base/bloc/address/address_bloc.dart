import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc(this._adressService) : super(AddressInitial()) {
    on<FetchCities>(_fetchCities);
    on<FetchDistricts>(_fetchDistricts);
  }
  final IAdressService _adressService;

  Future<void> _fetchCities(FetchCities event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final cities = await _adressService.fetchCities();
      emit(AddressCompleted(addressList: cities));
    } catch (e) {
      emit(AddressError(error: e.toString()));
    }
  }

  Future<void> _fetchDistricts(FetchDistricts event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final districts = await _adressService.fetchDistricts(event.cityId);
      emit(AddressCompleted(addressList: districts));
    } catch (e) {
      emit(AddressError(error: e.toString()));
    }
  }
}
