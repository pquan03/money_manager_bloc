import 'package:bloc/bloc.dart';
import 'package:money_manager/common/load_status.dart';

import '../../../models/transaction.dart';
import '../../../repositories/api.dart';

part 'list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  Api api;
  ListItemCubit(this.api) : super(const ListItemState.init());

  void loadData(int monthIdx) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading, selectedMonth: monthIdx));
    try {
      var months = await api.getMonths();
      emit(state.copyWith(months: months));
      var total = await api.getTotal();
      emit(state.copyWith(total: total));
      List<Transaction> trans = months.isEmpty ? [] :
          await api.getTransaction(state.months[state.selectedMonth]);
      emit(state.copyWith(trans: trans, loadStatus: LoadStatus.Done));
    } catch(ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }


  removeItem(String dateTime) {
    final listTrans = state.trans;
    listTrans.removeWhere((tran) => tran.dateTime == dateTime);
    emit(state.copyWith(trans: [...listTrans]));
  }

  undoItem(int index, Transaction tran) {
    final listTrans = state.trans;
    listTrans.insert(index, tran);
    emit(state.copyWith(trans: [...listTrans]));
  }


  Future<void> confirmRemoveItem(String dateTime) async {
    try {
      await api.deleteTransaction(dateTime);
    } catch(ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }

  Future<void> getTransByMonth(int selectedMonth) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading, selectedMonth: selectedMonth));
    try {
      var total = await api.getTotal();
      emit(state.copyWith(total: total));
      List<Transaction> trans = await api.getTransaction(state.months[state.selectedMonth]);
      emit(state.copyWith(trans: trans, loadStatus: LoadStatus.Done));
    } catch(ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }







}
