class Result {
  bool success;
  String resultCode;
  String resultMessage;

  Result(this.success, this.resultCode, this.resultMessage);

  Result.fromJSON(Map<String, dynamic> json): success = json['success'], resultCode = json['success'], resultMessage = json['resultMessage'];

  Map<String, dynamic> toJSON() => {
    'success': success,
    'resultCode': resultCode,
    'resultMessage': resultMessage
  };
}