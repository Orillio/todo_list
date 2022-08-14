
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:todo_list/business/api/back_api.dart';
import 'package:todo_list/models/todo_model.dart';
import 'i_todo_provider.dart';

class TodoProvider with ChangeNotifier implements ITodoProvider {
  static var api = BackApi();
  List<TodoModel>? _items;
  late Box<TodoModel> _box;
  late bool _isConnectedToInternet = false;

  TodoProvider() {
    _box = Hive.box<TodoModel>("todoBox");
    Connectivity().onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        _isConnectedToInternet = true;
      } else {
        _isConnectedToInternet = false;
      }
    });
  }
  @override
  int get itemsDone => _items?.where((e) => e.done).length ?? 0;

  @override
  Future<List<TodoModel>> get modelsListFuture async {
    return _items ??= await getItems();
  }

  @override
  Future addItem(TodoModel item) async {
    if (_isConnectedToInternet) {
      await api.addItem(item);
    }
    _box.put(item.id, item);
    _items?.add(item);
    notifyListeners();
  }

  @override
  Future deleteItem(TodoModel item) async {
    if (_isConnectedToInternet) {
      await api.deleteItem(item.id);
    }
    _box.values.firstWhere((e) => e.id == item.id).delete();
    _items?.removeWhere((e) => e.id == item.id);
    notifyListeners();
  }

  Future _mergeNewInfoWithBox(List<TodoModel> list) async {
    var deviceId = await PlatformDeviceId.getDeviceId;
    await _box.clear();
    await _box.addAll(list);
  }

  @override
  Future<List<TodoModel>> getItems() async {
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult != ConnectivityResult.none) {
      await api.updateList(_box.values.toList());
      var responseList = ((await api.getList()) as List<dynamic>).map((e) {
        return TodoModel.fromMap(e);
      }).toList();
      _mergeNewInfoWithBox(responseList);
      return responseList;
    }
    return _box.values.toList();
  }

  @override
  Future refreshList(List<TodoModel> list) async {
    await api.updateList(list);
    notifyListeners();
  }

  @override
  Future updateItem(TodoModel item) async {
    if (_isConnectedToInternet) {
      await api.updateItem(item);
    }
    var boxItem = _box.values.firstWhere((e) => e.id == item.id);

    await boxItem.pasteFromOther(item).save();

    notifyListeners();
  }

  @override
  int get totalItems => _items?.length ?? 0;
}
