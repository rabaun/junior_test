import 'package:junior_test/model/Home.dart';
import 'package:junior_test/model/actions/Promo.dart';
import 'package:junior_test/resources/api/RootType.dart';

class RootResponse {
  ServerResponse _serverResponse;
  RootTypes currentEvent;
  String _options;

  RootResponse({ServerResponse serverResponse}) {
    _serverResponse = serverResponse;
  }

  void setEventType(RootTypes type) {
    currentEvent = type;
  }

  void setCodeResponseOk() {
    _serverResponse = ServerResponse();
    _serverResponse.setCodeOk();
  }

  RootResponse.fromJson(Map<String, dynamic> json) {
    _serverResponse = json['serverResponse'] != null
        ? ServerResponse.fromJson(json['serverResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_serverResponse != null) {
      data['serverResponse'] = _serverResponse.toJson();
    }
    return data;
  }

  ServerResponse get serverResponse =>
      (_serverResponse ?? ServerResponse());

  set barcodeResult(String info) {
    _options = info;
  }

  String get barcodeResult => (_options ?? "");
}

class ServerResponse {
  Code _code;
  Body _body;

  ServerResponse({Code code, Body body}) {
    _code = code;
    _body = body;
  }

  ServerResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'] != null ? Code.fromJson(json['code']) : null;
    _body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_code != null) {
      data['code'] = _code.toJson();
    }
    if (_body != null) {
      data['body'] = _body.toJson();
    }
    return data;
  }

  Code get code => (_code ?? Code());

  Body get body => (_body ?? Body());

  void setCodeOk() {
    _code = Code();
    _code.setCustomCode(200);
  }
}

class Code {
  int _code;
  String _message;

  Code({int code, String message}) {
    _code = code;
    _message = message;
  }

  Code.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['message'] = _message;
    return data;
  }

  int get code => (_code ?? -1);

  String get message => (_message ?? "null");

  void setCustomCode(int code) {
    _code = code;
  }
}

class Body {
  Home _home;
  Promos _promo;

  Body({Home home, Promos promo}) {
    _home = home;
    _promo = promo;
  }

  Body.fromJson(Map<String, dynamic> json) {
    _promo = json['promo'] != null ? Promos.fromJson(json['promo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_promo != null) {
      data['promo'] = _promo.toJson();
    }
    return data;
  }

  Promos get promo => (_promo == null ? Promos() : _promo);
}
