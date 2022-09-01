import 'dart:convert';

class ApiRes {
  ApiRes({
    required this.code,
    required this.message,
  });

  int code;
  String message;

  factory ApiRes.fromJson(String str) => ApiRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiRes.fromMap(Map<String, dynamic> json) => ApiRes(
    code: json["code"] ?? 0,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
  };

  factory ApiRes.create() => ApiRes(
    code: 0,
    message: ''
  );
}

class ApiDataRes<T> {
  ApiDataRes({
    required this.code,
    this.body,
  });

  int code;
  T? body;

  factory ApiDataRes.fromJson(String str) => ApiDataRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiDataRes.fromMap(Map<String, dynamic> json) => ApiDataRes(
    code: json["code"],
    body: json["body"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "body": body,
  };

  factory ApiDataRes.create() => ApiDataRes(
    code: 10000,
  );
}