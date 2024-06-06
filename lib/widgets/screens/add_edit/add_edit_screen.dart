import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';

import '../../../models/transaction.dart';

class AddEditScreen extends StatelessWidget {
  static const String routeName = 'add_edit_screen';
  final bool isAddMode;

  const AddEditScreen({super.key, required this.isAddMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isAddMode ? 'Add Transaction' : 'Edit Transaction'),),
        body: BlocBuilder<ListItemCubit, ListItemState>(
          builder: (context, state) {
            var _title = TextEditingController();
            var _amount = TextEditingController();
            var _content = TextEditingController();
            var _cubit = context.read<ListItemCubit>();
            if(!isAddMode) {
              var item = state.trans[state.selectedIdx];
              _title.text = item.title;
              _amount.text = item.amount.toString();
              _content.text = item.content;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12,10, 12, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: _title,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _amount,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _content,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if(isAddMode) {
                            _cubit.addTransaction(Transaction(
                              title: _title.text,
                              amount: double.parse(_amount.text),
                              content: _content.text,
                              dateTime: DateTime.now().toString()
                            ));
                            Navigator.pop(context);
                          } else {
                            _cubit.editTransaction(Transaction(
                              title: _title.text,
                              amount: double.parse(_amount.text),
                              content: _content.text,
                              dateTime: state.trans[state.selectedIdx].dateTime
                            ));
                            Navigator.of(context).popUntil(ModalRoute.withName(ListItemScreen.routeName));
                          }

                        },
                        child: Text(isAddMode ? 'Add' : 'Edit', style: const TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
