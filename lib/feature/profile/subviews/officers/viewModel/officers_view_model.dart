
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';

class OfficersViewModel extends IBaseViewModel {
  late UserBloc userBloc;

  @override
  Future<void> init() async {
    try {
      userBloc = context!.read<UserBloc>();
      userBloc.add(FetchAllUsers());
    } catch (e, stackTrace) {


      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }
    return Future.value();
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}
