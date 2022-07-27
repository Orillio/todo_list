import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class BackApi {

  static const _baseUrl = "https://beta.mrdekk.ru/todobackend";
  static const _token = "https://beta.mrdekk.ru/todobackend";
  static final BackApi _instance = BackApi._internal();
  static int? _revision;

  static final _logger = Logger();
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      contentType: "application/json",
      headers: {
        "X-Last-Known-Revision": _revision,
        "Authorization": "Bearer Odonwell"
      }
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
        options: Options(
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
          _logger.w(
              "Getting up to date revision..."
          );
        }
        _revision = await getUpToDateRevision();
        request(relativeUrl, method: method, retry: false);
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

  Future<Response> getTodoList() async {
    var response = await request("/list/", method: "GET");
    return response.data["revision"];
  }

}