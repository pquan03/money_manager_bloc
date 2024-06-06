import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';



class DetailScreen extends StatelessWidget {
  static const String routeName = 'detail_screen';

  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        final item = state.trans[state.selectedIdx];
        return Scaffold(
          appBar: AppBar(
            title: Text(item.title),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(12,10, 12, 0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Amount'),
                  subtitle: Text(item.amount.toString()),
                ),
                ListTile(
                  title: const Text('Date'),
                  subtitle: Text(item.dateTime),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      var cubit = context.read<ListItemCubit>();
                      Navigator.of(context).pushNamed(AddEditScreen.routeName, arguments: {
                        'cubit': cubit,
                        'isAddMode': false
                      });
                    },
                    child: const Text('Edit', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
