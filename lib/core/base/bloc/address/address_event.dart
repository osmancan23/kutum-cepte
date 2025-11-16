part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

final class FetchCities extends AddressEvent {}

final class FetchDistricts extends AddressEvent {
  FetchDistricts({required this.cityId});

  final int cityId;
}

