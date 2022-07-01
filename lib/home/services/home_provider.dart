import '../../models/tudu.dart';
import '../../db_helper/db_helper.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  List<Tudu> _tuduList = [];
  List<Tudu> get tuduList => _tuduList;

  Future<bool> getAllTudusFromDatabase() async {
    _tuduList = await DBHelper.getAllTudu();
    if (_tuduList.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> addTuduToDatabase(Tudu tudu) async {
    int id = await DBHelper.insertTudu(tudu);
    if (id != 0) {
      tudu.id = id;
      _tuduList.add(tudu);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateTuduInDatabase(Tudu tudu) async {
    await DBHelper.updateTudu(tudu);
    int index = _tuduList.indexWhere((element) => element.id == tudu.id);
    _tuduList.removeAt(index);
    _tuduList.insert(index, tudu);
    notifyListeners();
    return true;
  }

  Future<bool> deleteTuduInDatabase(Tudu tudu) async {
    await DBHelper.delete(tudu);
    _tuduList.removeWhere((element) => element.id == tudu.id);
    notifyListeners();
    return true;
  }
}
