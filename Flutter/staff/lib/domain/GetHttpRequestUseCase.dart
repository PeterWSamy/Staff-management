import 'package:dio/dio.dart';

class GetHttpRequestUseCase {
  GetHttpRequestUseCase._privateConstructor();

  // Singleton instance
  static final GetHttpRequestUseCase _instance =
      GetHttpRequestUseCase._privateConstructor();

  // Getter to access the instance
  static GetHttpRequestUseCase get instance => _instance;

  final dio = Dio();

  Future<Response> post(uri, Map<String, dynamic> data) async {
    try {
      return await dio.post(uri, data: data);
    } catch (e) {
      print(e);
      return Response(
          requestOptions: RequestOptions(path: "fucked up", data: ""));
    }
  }

  Future<Response> get(uri, headers,data) async {
    try {
      return await dio.get(uri, queryParameters: headers,data: data);
    } catch (e) {
      print(e);
      return Response(
          requestOptions: RequestOptions(path: "fucked up", data: ""));
    }
  }

  Future<Response> delete(uri)async{
     try {
      return await dio.delete(uri);
    } catch (e) {
      print(e);
      return Response(
          requestOptions: RequestOptions(path: "fucked up", data: ""));
    }
  }
}
