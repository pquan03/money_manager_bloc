

import 'package:money_manager/models/login.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/repositories/log.dart';


class ApiImpl implements Api {
  Log log;
   final List<Transaction> _data = [
    const Transaction(dateTime: "2024-02-15 15:00:00", title: "a", content: "aa", amount: 1000),
    const Transaction(dateTime: "2024-03-10 10:00:00", title: "b", content: "bb", amount: -10),
    const Transaction(dateTime: "2024-03-10 12:00:00", title: "c", content: "cc", amount: -20),
    const Transaction(dateTime: "2024-03-10 9:00:00", title: "d", content: "dd", amount: -50),
  ];

  ApiImpl(this.log) {
    _data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }



  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<bool> checkLogin(Login login) async {
   await delay();
   if(login.username == '1' && login.password == '1') {
     return Future(() => true);
   }
   return Future(() => false);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await delay();
    for(var obj in _data) {
      if(obj.dateTime == transaction.dateTime) throw Exception('Duplicate');
    }

    _data.add(transaction);
    _data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }


  @override
  Future<void> deleteTransaction(String dateTime) async {
     await delay();
     for(int i = 0; i < _data.length; i++) {
       if(_data[i].dateTime == dateTime) {
         _data.removeAt(i); return;
       }
     }
     throw Exception("Not found data!");
  }

  @override
  Future<void> editTransaction(Transaction transaction) async {
    await delay();
    for(int i = 0; i < _data.length; i++) {
      if(_data[i].dateTime == transaction.dateTime) {
        _data[i] = transaction;
      }
    }
    throw Exception("Not found data!");
  }

  @override
  Future<List<String>> getMonths() async {
    await delay();
    Set<String> rs = {};
    for(final o in _data) {
      rs.add(o.dateTime.substring(0,7));
    }
    return rs.toList();
  }

  @override
  Future<double> getTotal() async {
    await delay();
    double total = 0;
    for(final obj in _data) {
      total += obj.amount;
    }
    return total;
  }

  @override
  Future<double> getTotalByMonth(String moth) async {
    await delay();
    double total = 0;
    for(final obj in _data) {
      if(obj.dateTime.startsWith(moth)) total += obj.amount;
    }
    return total;
  }



  @override
  Future<List<Transaction>> getTransaction(String month) async {
    await delay();
    List<Transaction> rs = [];
    for(final o in _data) {
      var tmp = o.dateTime.substring(0, 7);
      if(month.startsWith(tmp)) rs.add(o);
    }
    return rs;
  }

}