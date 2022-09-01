
import 'dart:convert';

class LoginRes {
  LoginRes({
    required this.code,
    required this.message,
    required this.token,
    required this.email,
    required this.account,
    required this.rank,
  });

  int code;
  String message;
  String token;
  String email;
  String account;
  int rank;

  factory LoginRes.fromJson(String str) => LoginRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRes.fromMap(Map<String, dynamic> json) => LoginRes(
    code: json["code"] ?? 0,
    message: json["message"] ?? "",
    token: json["token"] ?? "",
    email: json["email"] ?? "",
    account: json["account"] ?? "",
    rank: json["rank"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
    "token": token,
    "email": email,
    "account": account,
    "rank": rank,
  };

  factory LoginRes.create() => LoginRes(
    code: 0,
    message: "",
    token: "",
    email: "",
    account: "",
    rank: 0,
  );
}

class User {
  User({
    required this.token,
    required this.email,
    required this.account,
    required this.rank,
  });

  String token;
  String email;
  String account;
  int rank;
}

class TLogin {
  TLogin({
    required this.account,
    required this.password
  });

  String account;
  String password;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "account": account,
    "password": password,
  };
}

class TThirdLogin {
  TThirdLogin({
    required this.account,
    required this.email
  });

  String account;
  String email;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "email": email,
    "account": account,
  };
}

class TRegister {
  TRegister({
    required this.account,
    required this.email,
    required this.password
  });

  String account;
  String email;
  String password;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "email": email,
    "account": account,
    "password": password,
  };
}