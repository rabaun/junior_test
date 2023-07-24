import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/resources/api/RootType.dart';

import '../../model/actions/PromoItem.dart';

class MallApiProvider {
  Client client = Client();
  final _baseUrlMall = "https://bonus.andreyp.ru/api/v1/";
  static const baseImageUrl = "https://bonus.andreyp.ru/";
  final _url = "https://bonus.andreyp.ru/api/v1/promos?page={номер_страницы}&count={кол-во элементов}";

  MallApiProvider(this.model);

  Future<RootResponse> _baseGETfetchWithEvent(
      RootTypes event, String url) async {
    try {
      Response response = await client.get(_baseUrlMall + url);
      if (response.statusCode == 200) {
        RootResponse resp = RootResponse.fromJson(json.decode(response.body));
        resp.setEventType(event);
        return resp;
      } else {
        return RootResponse();
      }
    } on Exception catch (e) {
      if (!e.toString().contains('HttpException')) {
        RootResponse resp = RootResponse();
        resp.setEventType(RootTypes.EVENT_NETWORK_EXCEPTION);
        return resp;
      }
    }
  }

  Future<RootResponse> _basePOSTfetchWithEvent(
      RootTypes event, String url, Object args) async {
    print(_baseUrlMall + url);
    Response request = await client.post(_baseUrlMall + url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: args);
    print(request.body);
    if (request.statusCode == 200) {
      RootResponse resp = RootResponse.fromJson(json.decode(request.body));
      resp.setEventType(event);
      return resp;
    } else {
      return RootResponse();
    }
  }

  final _baseUrl = "https://bonus.andreyp.ru/api/v1/";

  final PromoItem model;

  Future<List<PromoItem>> baseGET() async {
    final res = await client.get(Uri.parse(_baseUrl));
    if (res.statusCode == 200) {
      final result = (res.body[1][2] as List).map((e) {
        return MyModel.fromJson(e);
      }).toList();
      model = result as MyModel?;
      return result;
    }
    return null;
  }

  Future<RootResponse> fetchActionInfo(int id) {
    return _baseGETfetchWithEvent(RootTypes.EVENT_ACTION_ITEM, "promo?id=$id");
  }
}
