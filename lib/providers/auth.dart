import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  var api_key = 'AIzaSyAcYJpoZCcX-wN5ll2kVmUQEjRFWpd2NU4';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$api_key');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      // print(json.decode(response.body));
      final responseData = json.decode(response.body.toString());
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}


// 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImM4MjNkMWE0MTg5ZjI3NThjYWI4NDQ4ZmQ0MTIwN2ViZGZhMjVlMzkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2hvcGFwcC1jZDYwNCIsImF1ZCI6InNob3BhcHAtY2Q2MDQiLCJhdXRoX3RpbWUiOjE2ODE2Njc5MzIsInVzZXJfaWQiOiJsRVRJTGdhNUFpZ0tJT2Vyd2JicTFPdWtPVmUyIiwic3ViIjoibEVUSUxnYTVBaWdLSU9lcndiYnExT3VrT1ZlMiIsImlhdCI6MTY4MTY2NzkzMiwiZXhwIjoxNjgxNjcxNTMyLCJlbWFpbCI6InlvZ2VzaEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsieW9nZXNoQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.Gkzp6ummrtXENNM59kWPFRme1b0SOoPAYYuE0HTFR6xSXVdThOPSQPftY-_ydWh737QTRMyt6zTQEzJ6aUgRNt9RyCzOgG1YljjHqPACIJvhq5-T8noHxJRblv50v98O-CB_xm5wRvyfIFHAP_Zckmgl6Z470eO9LVT5M7o2H--8nLMfUImQde9bRLPOUzfKdbXAFnwy8v1l0qmcIfjmgBJ97a8vs7GXX0ubtvkbiKB56ayq0q6hmIrQUY8XSSaS7vEkDEz63t_7jrmlmhdfRpL9xKK-jxv2VBUlyN6-3q3EtCwGCz1rKeq1VFSjQmtv'