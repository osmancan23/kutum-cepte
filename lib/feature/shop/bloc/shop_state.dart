part of 'shop_bloc.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopListLoading extends ShopState {}

final class ShopListLoaded extends ShopState {
  ShopListLoaded(this.shopList);
  final List<ShopModel> shopList;
}

final class ShopListLoadError extends ShopState {
  ShopListLoadError(this.error);
  final String error;
}

final class ShopDetailLoading extends ShopState {}

final class ShopDetailLoaded extends ShopState {
  ShopDetailLoaded(this.shop);
  final ShopModel shop;
}

final class ShopDetailLoadError extends ShopState {
  ShopDetailLoadError(this.error);
  final String error;
}

final class ShopCreating extends ShopState {}

final class ShopCreated extends ShopState {}

final class ShopCreateError extends ShopState {
  ShopCreateError(this.error);
  final String error;
}

final class ShopUpdating extends ShopState {}

final class ShopUpdated extends ShopState {}

final class ShopUpdateError extends ShopState {
  ShopUpdateError(this.error);
  final String error;
}

final class ShopDeleting extends ShopState {}

final class ShopDeleted extends ShopState {}

final class ShopDeleteError extends ShopState {
  ShopDeleteError(this.error);
  final String error;
}

final class ResetShopsState extends ShopState {}

final class ShopResetting extends ShopState {}

final class ShopResetted extends ShopState {}
final class ShopResetError extends ShopState {
  ShopResetError(this.error);
  final String error;
}

final class ShopNoChanging extends ShopState {}

final class ShopNoChanged extends ShopState {}

final class ShopNoChangeError extends ShopState {
  ShopNoChangeError(this.error);
  final String error;
}

final class ShopHistoryLoading extends ShopState {}

final class ShopHistoryLoaded extends ShopState {
  ShopHistoryLoaded(this.shopHistoryList);
  final List<ShopHistoryModel> shopHistoryList;
}

final class ShopHistoryLoadError extends ShopState {
  ShopHistoryLoadError(this.error);
  final String error;
}

final class ShopHistoryCreating extends ShopState {}

final class ShopHistoryCreated extends ShopState {}

final class ShopHistoryCreateError extends ShopState {
  ShopHistoryCreateError(this.error);
  final String error;
}

final class AllShopHistoryLoading extends ShopState {}

final class AllShopHistoryLoaded extends ShopState {
  AllShopHistoryLoaded(this.shopHistoryList);
  final List<ShopHistoryModel> shopHistoryList;
}

final class AllShopHistoryLoadError extends ShopState {
  AllShopHistoryLoadError(this.error);
  final String error;
}
