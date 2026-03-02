import 'package:get/get.dart';
import 'package:project/Data/models/login_model.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';
import 'package:project/ui/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );
    if (response.isSuccess) {
      LoginModel loginModel = await LoginModel.fromJson(response.resposeData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
