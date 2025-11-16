import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/service/firebase/firebase_storage_service.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_create_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_history_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_image_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_update_model.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc(this._shopService) : super(ShopInitial()) {
    on<FetchAllShops>(_fetchAllShops);
    on<FetchShopDetail>(_fetchShopDetail);
    on<CreateShop>(_createShop);
    on<UpdateShop>(_updateShop);
    on<DeleteShop>(_deleteShop);
    on<ResetShops>(_resetShops);
    on<ChangeShopNo>(_changeShopNo);

    // SHOP HISTORY

    on<FetchShopHistoryById>(_fetchShopHistoryById);
    on<CreateShopHistory>(_createShopHistory);
    on<FetchAllShopHistories>(_fetchAllShopHistories);
  }
  final IShopService _shopService;

  Future<void> _fetchAllShops(FetchAllShops event, Emitter<ShopState> emit) async {
    emit(ShopListLoading());
    try {
      final shopList = await _shopService.fetchAllShops(sehirId: event.sehirId, ilceId: event.ilceId);
      emit(ShopListLoaded(shopList));
    } catch (e) {
      emit(ShopListLoadError(e.toString()));
    }
  }

  Future<void> _fetchShopDetail(FetchShopDetail event, Emitter<ShopState> emit) async {
    emit(ShopDetailLoading());
    try {
      final shop = await _shopService.fetchShopDetail(event.shopId);
      if (shop != null) {
        emit(ShopDetailLoaded(shop));
      } else {
        emit(ShopDetailLoadError('Shop not found'));
      }
    } catch (e) {
      emit(ShopDetailLoadError(e.toString()));
    }
  }

  Future<void> _createShop(CreateShop event, Emitter<ShopState> emit) async {
    final imageUrls = <String>[];
    emit(ShopCreating());
    final shopId = ''.generateUniqueId();
    try {
      for (final imageModel in event.images) {
        if (imageModel.image == null) continue;
        final path = '${FirebaseStoragePathEnum.shop.value}/$shopId/image${imageModel.id}';
        final imageUrl = await locator<FirebaseStorageService>().uploadFile(
          file: imageModel.image!,
          path: path,
        );
        imageUrls.add(imageUrl);
      }
      event.shop.shopPhotosUrl = imageUrls;
      event.shop.firebaseShopID = shopId;
      final response = await _shopService.createShop(event.shop);
      response.fold(
        onSuccess: (value) {
          emit(ShopCreated());
        },
        onError: (error) {
          emit(ShopCreateError(error.model?.message ?? 'Bir hata oluştu'));
        },
      );
    } catch (e) {
      emit(ShopCreateError(e.toString()));
    }
  }

  Future<void> _updateShop(UpdateShop event, Emitter<ShopState> emit) async {
    final imageUrls = <String>[];

    emit(ShopUpdating());
    for (final imageModel in event.images) {
      if (imageModel.image == null) continue;

      event.shop.firebaseShopID ??= ''.generateUniqueId();

      final path = '${FirebaseStoragePathEnum.shop.value}/${event.shop.firebaseShopID}/image${imageModel.id}';
      final imageUrl = await locator<FirebaseStorageService>().uploadFile(
        file: imageModel.image!,
        path: path,
      );
      imageUrls.add(imageUrl);
    }
    event.shop.shopPhotosUrl = imageUrls;
    try {
      final response = await _shopService.updateShop(event.shopId, event.shop);
      response.fold(
        onSuccess: (value) {
          emit(ShopUpdated());
        },
        onError: (error) {
          emit(ShopUpdateError(error.model?.message ?? 'Bir hata oluştu'));
        },
      );
    } catch (e) {
      emit(ShopUpdateError(e.toString()));
    }
  }

  Future<void> _deleteShop(DeleteShop event, Emitter<ShopState> emit) async {
    emit(ShopDeleting());
    try {
      final response = await _shopService.deleteShop(event.shopId);
      response.fold(
        onSuccess: (value) {
          emit(ShopDeleted());
        },
        onError: (error) {
          emit(ShopDeleteError(error.model?.message ?? 'Bir hata oluştu'));
        },
      );
    } catch (e) {
      emit(ShopDeleteError(e.toString()));
    }
  }

  Future<void> _resetShops(ResetShops event, Emitter<ShopState> emit) async {
    emit(ResetShopsState());
    try {
      final response = await _shopService.resetShops(event.sehirId);
      response.fold(
        onSuccess: (value) {
          emit(ShopResetted());
        },
        onError: (error) {
          emit(ShopResetError(error.model?.message ?? 'Bir hata oluştu'));
        },
      );
    } catch (e) {
      emit(ShopResetError(e.toString()));
    }
  }

  Future<void> _changeShopNo(ChangeShopNo event, Emitter<ShopState> emit) async {
    emit(ShopNoChanging());
    try {
      final response = await _shopService.changeShopNo(shopId: event.shopId, newShopNo: 1);
      response.fold(
        onSuccess: (value) {
          emit(ShopNoChanged());
        },
        onError: (error) {
          emit(ShopNoChangeError(error.model?.message ?? 'Bir hata oluştu'));
        },
      );
    } catch (e) {
      emit(ShopNoChangeError(e.toString()));
    }
  }

  // SHOP HISTORY

  Future<void> _fetchShopHistoryById(FetchShopHistoryById event, Emitter<ShopState> emit) async {
    emit(ShopHistoryLoading());
    try {
      final shopHistoryList = await _shopService.fetchShopHistoryById(shopId: event.shopId);
      emit(ShopHistoryLoaded(shopHistoryList));
    } catch (e) {
      emit(ShopHistoryLoadError(e.toString()));
    }
  }

  Future<void> _createShopHistory(CreateShopHistory event, Emitter<ShopState> emit) async {
    emit(ShopHistoryCreating());
    try {
      final response = await _shopService.createShopHistory(event.shopHistory);
      response.fold(
        onSuccess: (value) {
          emit(ShopHistoryCreated());
          // Fetch all shops after successful creation of shop history
          add(
            FetchAllShops(
              sehirId: event.sehirId,
              ilceId: event.ilceId,
            ),
          );
        },
        onError: (error) {
          emit(ShopHistoryCreateError(error.model?.message ?? 'Bir hata oluştu'));
        },
      );
    } catch (e) {
      emit(ShopHistoryCreateError(e.toString()));
    }
  }

  Future<void> _fetchAllShopHistories(FetchAllShopHistories event, Emitter<ShopState> emit) async {
    emit(ShopHistoryLoading());
    try {
      final shopHistoryList = await _shopService.fetchAllShopHistories();
      emit(ShopHistoryLoaded(shopHistoryList));
    } catch (e) {
      emit(ShopHistoryLoadError(e.toString()));
    }
  }
}
