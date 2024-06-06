import 'package:bloc/bloc.dart';

import '../../common/drawer_item.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState.init());


  void setSelected(DrawerItem item) {
    emit(state.copyWith(selected: item));
  }

  void setTheme(bool isLightTheme) {
    emit(state.copyWith(isLightTheme: isLightTheme));
  }
}
