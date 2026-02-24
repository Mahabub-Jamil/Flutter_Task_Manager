class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  dynamic resposeData;
  String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.resposeData,
    this.errorMessage = 'Something went wrong',
  });
}
