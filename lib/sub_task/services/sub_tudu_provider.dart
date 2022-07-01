import 'package:tatudu/models/sub_tudu.dart';

import '../../db_helper/db_helper.dart';
import 'package:flutter/foundation.dart';

class SubTuduProvider extends ChangeNotifier {
  List<SubTudu> _subTuduList = [];
  List<SubTudu> get subTuduList => _subTuduList;

  Future<bool> getAllTudusFromDatabase(String parentTuduId) async {
    _subTuduList = await DBHelper.getAllSubTudu(parentTuduId);
    if (_subTuduList.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> addSubTuduToDatabase(SubTudu subTudu) async {
    int id = await DBHelper.insertSubTudu(subTudu);
    if (id != 0) {
      subTudu.id = id;
      _subTuduList.add(subTudu);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateSubTuduIsCompletedInDatabase(SubTudu subTudu) async {
    await DBHelper.setSubTuduIsCompleted(subTudu);
    int index = _subTuduList.indexWhere((element) => element.id == subTudu.id);
    _subTuduList.removeAt(index);
    _subTuduList.insert(index, subTudu);
    notifyListeners();
    return true;
  }
}
