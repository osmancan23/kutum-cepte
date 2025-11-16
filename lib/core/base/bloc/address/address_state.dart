part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressCompleted extends AddressState {
  AddressCompleted({required this.addressList});

  final List<AddressModel> addressList;
}

final class AddressError extends AddressState {
  AddressError({required this.error});

  final String error;
}
