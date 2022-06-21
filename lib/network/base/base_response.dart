class BaseResponse {
  dynamic data;
  int? statusCode;
  String? message;
  String? friendlyMessage;

  BaseResponse({
    this.data,
    this.statusCode,
    this.message,
    this.friendlyMessage,
  });

  BaseResponse copyWith({
    dynamic data,
    int? statusCode,
    String? message,
    String? friendlyMessage,
  }) =>
      BaseResponse(
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        friendlyMessage: friendlyMessage ?? this.friendlyMessage,
      );

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        data: json["data"],
        statusCode: json["statusCode"],
        message: json["message"],
        friendlyMessage: json["friendlyMessage"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "statusCode": statusCode,
        "message": message,
        "friendlyMessage": friendlyMessage,
      };
}
