
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/models/todo_model.dart';

class BackApi {

  static const _baseUrl = "https://beta.mrdekk.ru/todobackend";
  static final BackApi _instance = BackApi._internal();
  static int? _revision;

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

  static final _logger = Logger();
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
    )
  );
  BackApi._internal();
  factory BackApi() {
    return _instance;
  }
  /// General request method. Has retry parameter.
  /// true - retries the request iff revisions aren't equal.
  Future<Response> request(String relativeUrl, {String method = "get", dynamic data, retry = true}) async {
    Response response;
    try {
      response = await _dio.request(
        relativeUrl,
        data: data,
        options: Options(
          headers: {
            "X-Last-Known-Revision": _revision,
            "Authorization": "Bearer Odonwell",
          },
          method: method.toUpperCase(),
        )
      );
      return response;
    }
    on DioError catch(e) {
      if(retry && e.response?.statusCode == 400) {
        if(_revision != null) {
          _logger.w(
            "Either revision is obsolete or request has incorrect structure.\n"
            "Getting new revision, and retrying the request..."
          );
        }
        else {
          _logger.i(
              "Getting up to date revision..."
          );
        }
        _revision = await getUpToDateRevision();
        return await request(relativeUrl, method: method, data: data, retry: false);
      }
      _logger.wtf(
          "Some error happened. Printing Stack Trace..."
      );
      rethrow;
    }
  }

  /// For updating revision. Though this can only be done by calling list method.
  Future<int> getUpToDateRevision() async {
    var response = await request("/list/", method: "GET");
    return response.data["revision"];
  }

  Future<dynamic> getList() async {
    var response = await request("/list/", method: "GET");
    return response.data["list"];
  }
  Future addItem(TodoModel model) async {
    var response = await request(
      "/list/",
      method: "POST",
      data: fromItemTemplate(model.toMap())
    );
    _revision = _revision! + 1;
    Logger().i("Following item has been added:\n${response.data}");
  }
  Future updateList(List<TodoModel> model) async {
    var response = await request(
      "/list/",
      method: "PATCH",
      data: fromListTemplate(model.map((e) => e.toMap()).toList())
    );
    _revision = _revision! + 1;
    Logger().i("Following item has been added:\n${response.data}");
  }
  Future deleteItem(String id) async {
    await request(
      "/list/$id",
      method: "DELETE",
    );
    _revision = _revision! + 1;
    Logger().i("Item with id: $id has been deleted.");
  }
  Future<Response> getItem(String id) async {
    var response = await request(
      "/list/${id}",
      method: "GET",
    );
    return response;
  }
  Future updateItem(TodoModel model) async {
    var response = await request(
      "/list/${model.id}",
      method: "PUT",
      data: fromItemTemplate(model.toMap())
    );
    _revision = _revision! + 1;
    Logger().i("Following item has been updated:\n${response.data}");
  }
}