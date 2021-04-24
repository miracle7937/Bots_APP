class APIException implements Exception {
  static APIException generic = APIException(
      'generic_error', 'An error has occured, please try again later.');

  /// * A code returned from the API.
  String code;

  int statusCode;

  String message;

  String details;

  APIException(this.code, this.message);

  APIException.fromJson(Map<String, dynamic> json, [int statusCode]) {
    Map<String, dynamic> _json = json;
    if (json.containsKey("error")) {
      /// Integration error format
      /// ```json
      /// {
      ///   "error": {
      ///     "code": "sochitel_4",
      ///     "message": "Invalid amount",
      ///     "status": 500
      ///   }
      /// }
      /// ```
      _json = json['error'];
    }
    code = _json['code'];
    message = _json['message'];
    details = _json['details'];
    this.statusCode = statusCode;

    if (statusCode >= 500) {
      message = 'Please check you internet connection';
    } else {
      message = 'An error has occured.';
    }
  }

  @override
  String toString() => message;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is APIException &&
        o.code == code &&
        o.message == message &&
        o.statusCode == statusCode &&
        o.details == details;
  }

  @override
  int get hashCode =>
      code.hashCode ^ message.hashCode ^ statusCode.hashCode ^ details.hashCode;
}
