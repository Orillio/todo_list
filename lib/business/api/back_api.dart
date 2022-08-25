import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/business/api/api.dart';
import 'package:todo_list/models/todo_model.dart';

class BackApi implements Api {
  BackApi._internal();

  static final BackApi _instance = BackApi._internal();

  factory BackApi() {
    return _instance;
  }

  static const _baseUrl = "https://beta.mrdekk.ru/todobackend";
  static int? _revision;

  static final _logger = Logger();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
    ),
  );

  Map<String, dynamic> fromItemTemplate(Map<String, dynamic> data) {
    return {
      "status": "ok",
      "element": data,
    };
  }

  Map<String, dynamic> fromListTemplate(List<Map<String, dynamic>> data) {
    return {
      "status": "ok",
      "list": data,
    };
  }

  /// General request method. Has retry parameter.
  /// true - retries the request iff revisions aren't equal.
  Future<Response> request(String relativeUrl,
      {String method = "get", dynamic data, retry = true}) async {
    Response response;
    try {
      response = await _dio.request(
        relativeUrl,
        data: data,
        options: Options(
          headers: {
            "X-Last-Known-Revision": _revision,
            "Authorization": "Bearer ${dotenv.env["TODO_TOKEN"]}",
          },
          method: method.toUpperCase(),
        ),
      );
      return response;
    } on DioError catch (e) {
      if (retry && e.response?.statusCode == 400) {
        if (_revision != null) {
          _logger.w(
              "Either revision is obsolete or request has incorrect structure.\n"
              "Getting new revision, and retrying the request...");
        } else {
          _logger.i("Getting up to date revision...");
        }
        _revision = await getUpToDateRevision();
        return await request(relativeUrl,
            method: method, data: data, retry: false);
      }
      _logger.wtf("ERROR: ${e.message}");
      rethrow;
    }
  }

  /// For updating revision. Though this can only be done by calling list method.
  @override
  Future<int> getUpToDateRevision() async {
    var response = await request("/list/", method: "GET");
    return response.data["revision"];
  }

  @override
  Future<void> addItem(TodoModel model) async {
    var response = await request("/list/",
        method: "POST", data: fromItemTemplate(model.toJson()));
    _revision = _revision! + 1;
    _logger.i("Following item has been added:\n${response.data}");
  }

  @override
  Future<void> updateList(List<TodoModel> model) async {
    var response = await request("/list/",
        method: "PATCH",
        data: fromListTemplate(model.map((e) => e.toJson()).toList()));
    _revision = _revision! + 1;
    _logger.i("Following list has been merged:\n${response.data}");
  }

  @override
  Future<void> deleteItem(String id) async {
    await request(
      "/list/$id",
      method: "DELETE",
    );
    _revision = _revision! + 1;
    _logger.i("Item with id: $id has been deleted.");
  }

  @override
  Future<void> updateItem(TodoModel model) async {
    var response = await request("/list/${model.id}",
        method: "PUT", data: fromItemTemplate(model.toJson()));
    _revision = _revision! + 1;
    _logger.i("Following item has been updated:\n${response.data}");
  }

  @override
  Future<List<TodoModel>> getTasksList() async {
    var response = await request("/list/", method: "GET");
    return (response.data['list'] as List)
        .map((e) => TodoModel.fromJson(e))
        .toList();
  }
}
