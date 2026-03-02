import 'package:get/get.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  bool get isSubmitted => _isSubmitted;
  void setSubmitted(bool value) => _isSubmitted = value;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": "",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );
    if (response.isSuccess) {
      isSuccess = true;
      _isSubmitted = false;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
