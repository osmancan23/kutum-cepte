part of '../shop_detail_view.dart';

mixin _ShopDetailViewMixin on State<ShopDetailView> {
  late ShopBloc _shopBloc;
  late ShopBloc _shopHistoryBloc;
  String? _appbarTitle;
  late StreamSubscription<ShopState> _shopBlocSubscription;
  late StreamSubscription<ShopState> _shopHistoryBlocSubscription;
  List<ShopCommentModel> _shopComments = [];
ShopModel? _shopModel;

  @override
  void initState() {
    _shopBloc = context.read<ShopBloc>();
    _shopHistoryBloc = ShopBloc(locator<ShopService>());
    _shopBloc.add(FetchShopDetail(widget.shopId));
    _shopHistoryBloc.add(FetchShopHistoryById(widget.shopId));
    super.initState();

    _shopBlocSubscription = _shopBloc.stream.listen((state) {
      if (state is ShopDetailLoaded) {
        _appbarTitle = state.shop.title;
        _shopModel = state.shop; 
        setState(() {});
      } else if (state is ShopDeleted) {
        if (mounted) {
          context.router.back();
        }
      }
    });

    _shopHistoryBlocSubscription = _shopHistoryBloc.stream.listen((state) {
      if (state is ShopHistoryLoaded) {
        _shopComments = state.shopHistoryList
            .map(
              (e) => ShopCommentModel(
                rating: e.point,
                comment: e.description,
                commentDate: e.date,
                userName: e.userInfoDto?.name,
                userSurname: e.userInfoDto?.surname,
                boxStatus: e.boxStatus,
              ),
            )
            .toList();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _shopBlocSubscription.cancel();
    _shopHistoryBlocSubscription.cancel();
    super.dispose();
  }
}
