part of '../shop_detail_view.dart';

Future<void> _taskHandOverPopupWidget(BuildContext context, {required int taskId, required int cityId}) async {
  int? selectedUserId;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            backgroundColor: context.general.colorScheme.onSecondary,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: context.border.highBorderRadius,
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            content: SizedBox(
              height: 600.h,
              width: 332.w,
              child: Column(
                children: [
                  Padding(
                    padding: context.padding.normal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _CloseWidget(),
                        _UserListWidget(
                          cityId: cityId,
                          onSelected: (userId) {
                            setState(() {
                              selectedUserId = userId;
                            });
                          },
                        ),
                        20.h.ph,
                        ButtonWidget(
                          onTap: () {
                            context
                                .read<TaskBloc>()
                                .add(HandOverCollectorTask(userId: selectedUserId!, taskId: taskId));
                            context.closePopup();
                            context.router.replace(const MainRoute());
                          },
                          text: 'Görevi Devret',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _UserListWidget extends StatefulWidget {
  const _UserListWidget({required this.onSelected, this.cityId});
  final void Function(int userId) onSelected;
  final int? cityId;
  @override
  State<_UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<_UserListWidget> {
  late UserBloc _userBloc;
  int? _selectedUserId;
  List<UserModel> allUser = [];
  List<UserModel> filterUserList = [];
  String word = '';
  @override
  void initState() {
    _userBloc = UserBloc(UserService());
    _userBloc.add(FetchUsersByCity(widget.cityId!));
    _userBloc.stream.listen((event) {
      if (event is UserListLoadCompleted) {
        allUser = event.users;
        setState(() {});
      }
    });
    super.initState();
  }

  void handleUserList(String keyword) {
    word = keyword;
    filterUserList = allUser.where((element) => '${element.name} ${element.surname}'.contains(keyword)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          hintText: 'Görevi Devredeceğiniz Kişi',
          width: 300,
          onChange: handleUserList,
        ),
        SizedBox(
          height: 350.h,
          child: _listView(word.isNotEmpty ? filterUserList : allUser),
        ),
      ],
    );
  }

  ListView _listView(List<UserModel> userList) {
    return ListView.builder(
      itemCount: userList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (userList.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Padding(
            padding: context.padding.verticalLow,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedUserId = userList[index].id;
                });
                widget.onSelected(userList[index].id!);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedUserId == userList[index].id
                      ? context.general.colorScheme.primary.withOpacity(0.2)
                      : null,
                  borderRadius: context.border.normalBorderRadius,
                ),
                child: OfficerTileWidget(
                  userModel: userList[index],
                  isHandOverWidget: true,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class _CloseWidget extends StatelessWidget {
  const _CloseWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => context.closePopup(),
          icon: Icon(
            Icons.close,
            color: context.general.colorScheme.secondary,
            size: 30.h,
          ),
        ),
      ],
    );
  }
}
