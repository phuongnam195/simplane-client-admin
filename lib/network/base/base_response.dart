class BaseResponse {
  dynamic data;
  int? result;
  String? errorMessage;
  String? friendlyMessage;

  BaseResponse({
    this.data,
    this.result,
    this.errorMessage,
    this.friendlyMessage,
  });

  BaseResponse copyWith({
    dynamic data,
    int? result,
    String? errorMessage,
    String? friendlyMessage,
  }) =>
      BaseResponse(
        data: data ?? this.data,
        result: result ?? this.result,
        errorMessage: errorMessage ?? this.errorMessage,
        friendlyMessage: friendlyMessage ?? this.friendlyMessage,
      );

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        data: json["data"],
        result: json["result"],
        errorMessage: json["errorMessage"],
        friendlyMessage: json["friendlyMessage"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "result": result,
        "errorMessage": errorMessage,
        "friendlyMessage": friendlyMessage,
      };
}
