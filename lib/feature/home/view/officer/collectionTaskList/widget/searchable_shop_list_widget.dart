part of '../collection_task_list_view.dart';

class _SearchableShopListWidget extends StatelessWidget {
  const _SearchableShopListWidget({
    required this.taskShops,
  });

  final List<TaskShopModel>? taskShops;

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: SearchableShopListViewModel(initialTaskShops: taskShops),
      builder: (viewModel) {
        return Column(
          children: [
            TextFormFieldWidget(
              hintText: 'Dükkan Ara',
              onChange: viewModel.filterShops,
            ),
            ValueListenableBuilder(
              valueListenable: viewModel._filteredTaskShops,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: viewModel.filteredTaskShops?.length ?? 0,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final taskShopModel = value?[index];
                    return Padding(
                      padding: context.padding.verticalLow,
                      child: _CollectionTaskTileWidget(taskShopModel),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class SearchableShopListViewModel extends IBaseViewModel {
  SearchableShopListViewModel({required this.initialTaskShops});

  final List<TaskShopModel>? initialTaskShops;

  // ValueNotifier ile dinlemek için

  final ValueNotifier<List<TaskShopModel>?> _filteredTaskShops = ValueNotifier<List<TaskShopModel>?>([]);

  List<TaskShopModel>? get filteredTaskShops => _filteredTaskShops.value;

  String _searchQuery = '';

  //getter
  String get searchQuery => _searchQuery;

  //setter
  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  @override
  Future<void> init() {
    _filteredTaskShops.value = initialTaskShops;
    return Future.value();
  }

  @override
  void reset() {
    _filteredTaskShops.dispose();
  }

  void filterShops(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredTaskShops.value = initialTaskShops;
    } else {
      _filteredTaskShops.value = initialTaskShops
          ?.where(
            (shop) => shop.shopByTaskCollectorDto!.title!.toLowerCase().contains(_searchQuery),
          ) // Dükkan ismine göre filtreleme
          .toList();
    }
  }
}
