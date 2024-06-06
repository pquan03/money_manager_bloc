import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/convert_date.dart';
import 'package:money_manager/common/load_status.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/common_widgets/noti_bar.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';


class ListItemScreen extends StatelessWidget {
  static const String routeName = 'list_item_screen';

  const ListItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ListItemCubit(context.read<Api>())
        ..loadData(0),
      child: const Page(),
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListItemCubit, ListItemState>(
        listener: (context, state) {
          if(state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(context).showSnackBar(notiBar('Fetch list item error', true));
          }
        },
        builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading ?
          const Center(child: CircularProgressIndicator(),):
          const ListItemPage();
        },
    );
  }
}


class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var cubit = context.read<ListItemCubit>();
          Navigator.pushNamed(context, AddEditScreen.routeName, arguments: {
            'cubit': cubit,
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ListItemCubit, ListItemState>(builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(text: TextSpan(
                      text: 'Total money: ',
                      children: [
                        TextSpan(
                          text:  '${state.total}',
                          style: const TextStyle(color: Colors.red)
                        )
                      ]
                    )),
                  ),
      
                 Expanded(
                   child: Row(children: [
                     IconButton(onPressed:
                     state.months.isNotEmpty && state.selectedMonth < state.months.length - 1 ? ()  {
                        context.read<ListItemCubit>().getTransByMonth(state.selectedMonth + 1);
                     } : null,
                         style: IconButton.styleFrom(
                             backgroundColor: Colors.grey.withOpacity(0.5),
                         ),
                      icon: const Icon(Icons.navigate_before_rounded, color: Colors.black, size: 20,)),
                     Expanded(child: Text(state.months[state.selectedMonth], textAlign: TextAlign.center,)),
                     IconButton(onPressed:
                     state.months.isNotEmpty && state.selectedMonth > 0 ? ()  {
                       context.read<ListItemCubit>().getTransByMonth(state.selectedMonth - 1);
                     } : null,
                         style: IconButton.styleFrom(
                           backgroundColor: Colors.grey.withOpacity(0.3),
                             disabledBackgroundColor:  Colors.grey.withOpacity(0.2),
                             disabledForegroundColor: Colors.grey
                         ),
                         icon: const Icon(Icons.navigate_next, size: 20,)),
      
                   ],),
                 )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = state.trans[index];
                  return Dismissible(
                    onDismissed: (direction) {
                    //   call delete state from bloc
                      int idxDeleted = index;
                      final item = state.trans[idxDeleted];
                      var isConfirmDelete = true;
                        context.read<ListItemCubit>().removeItem(item.dateTime);
                    //   show snackbar notify item is deleted and have undo button
                      ScaffoldMessenger.of(context).showSnackBar(
                        notiBar('Deleted item!', false, labelAction: 'Undo', pressed: () {
                          context.read<ListItemCubit>().undoItem(index, item);
                          isConfirmDelete = false;
                        }, duration: 3000
                      ),);
                      Future.delayed(const Duration(milliseconds: 3000), () {
                        if(isConfirmDelete) {
                          context.read<ListItemCubit>().confirmRemoveItem(item.dateTime);
                        }
                      });
                    },
                    key: Key(item.toString()),
                    child: Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.title),
                            Text(item.amount.toString())
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.content),
                            Text(convertDate(item.dateTime))
                          ],
                        ),
                        onTap: () {
                          var cubit = context.read<ListItemCubit>();
                          cubit.setSelectedIndex(index);
                          Navigator.pushNamed(context, DetailScreen.routeName, arguments: {
                            'cubit': cubit
                          });
                        },
                      ),
                    ),
                  );
                },
                itemCount: state.trans.length,
              ),
            )
          ],
        );
      }),
    );
  }
}


