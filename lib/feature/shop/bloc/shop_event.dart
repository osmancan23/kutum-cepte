part of 'shop_bloc.dart';

@immutable
sealed class ShopEvent {}

final class FetchAllShops extends ShopEvent {
  FetchAllShops({required this.sehirId, required this.ilceId});

  final int sehirId;
  final int ilceId;
}

final class FetchShopDetail extends ShopEvent {
  FetchShopDetail(this.shopId);
  final int shopId;
}

final class CreateShop extends ShopEvent {
  CreateShop(this.shop, this.images);
  final ShopCreateModel shop;
  final List<ShopImageModel> images;
}

final class UpdateShop extends ShopEvent {
  UpdateShop(this.shop, this.shopId, this.images);
  final ShopUpdateModel shop;
  final int shopId;
  final List<ShopImageModel> images;
}

final class DeleteShop extends ShopEvent {
  DeleteShop(this.shopId);
  final int shopId;
}



final class ChangeShopNo extends ShopEvent {
  ChangeShopNo(this.shopId);
  final int shopId;
}

final class FetchShopHistoryById extends ShopEvent {
  FetchShopHistoryById(this.shopId);
  final int shopId;
}

final class CreateShopHistory extends ShopEvent {
  CreateShopHistory(this.shopHistory, this.sehirId, this.ilceId);
  final ShopHistoryModel shopHistory;
  final int sehirId;
  final int ilceId;
}

final class ResetShops extends ShopEvent {
  ResetShops({required this.sehirId});

  final int sehirId;
}

final class FetchAllShopHistories extends ShopEvent {}
