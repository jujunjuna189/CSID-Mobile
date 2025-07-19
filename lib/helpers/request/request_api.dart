import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';

class RequestApi {
  String baseUrl = const String.fromEnvironment("APP_URL");

  Map errMsg = {
    'type': 'timeout',
    'message': 'Koneksi Internet lamban atau tidak ada, harap ulangi beberapa saat lagi!'
  };

  Future<http.Response> get({
    required String path,
    String? token,
    bool isLoading = true,
  }) async {
    Map<String, String>? headers = token != null ? {'Authorization': 'Bearer $token'} : {};
    if (isLoading) EasyLoading.show();
    try {
      http.Response res =
          await http.get(Uri.parse('$baseUrl$path'), headers: headers).timeout(const Duration(seconds: 10));

      EasyLoading.dismiss();
      return res;
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      return Future.error(jsonEncode(errMsg));
    } catch (e) {
      EasyLoading.dismiss();
      return Future.error(e.toString());
    }
  }

  Future<http.Response> post({
    required String path,
    required dynamic body,
    String? token,
    bool? useLoading = true,
    File? file,
  }) async {
    Map<String, String>? headers = token != null ? {'Authorization': 'Bearer $token'} : {};
    http.Response? response;

    if (useLoading != null && useLoading) {
      EasyLoading.show();
    }

    try {
      if (file != null) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var request = http.MultipartRequest("POST", Uri.parse('$baseUrl$path'));
        var multipartFile = http.MultipartFile('foto_s3', stream.cast(), length, filename: basename(file.path));

        body.keys.forEach((key) => {
              request.fields.addAll({key: body[key].toString()})
            });

        request.files.add(multipartFile);
        request.headers.addAll(headers);

        http.StreamedResponse streamedResponse = await request.send().timeout(const Duration(seconds: 15));
        response = await http.Response.fromStream(streamedResponse);
      } else {
        response = await http.post(
          Uri.parse('$baseUrl$path'),
          body: body,
          headers: headers,
        );
      }

      if (useLoading != null && useLoading) {
        EasyLoading.dismiss();
      }

      return response;
    } on SocketException catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
      return Future.error(jsonEncode(errMsg));
    } catch (e) {
      print(e.toString());
      if (useLoading != null && useLoading) {
        EasyLoading.dismiss();
      }
      return Future.error(e.toString());
    }
  }

  // Used to send every minutes proctoring photo to dashboard
  Future<int> postMultipart({
    required String path,
    required File file,
    String? token,
  }) async {
    try {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var request = http.MultipartRequest("POST", Uri.parse('$baseUrl$path'));
      var multipartFile = http.MultipartFile('LwsCamLib', stream.cast(), length, filename: basename(file.path));
      request.files.add(multipartFile);
      var response = await request.send();
      return response.statusCode;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
