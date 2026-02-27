class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String RecoverResetPass = '$_baseUrl/RecoverResetPass';
  static String RecoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String RecoverVerifyOTP(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String completedTaskList =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTaskList =
      '$_baseUrl/listTaskByStatus/Cancelled';
  static const String progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String profileUpdate = '$_baseUrl/profileUpdate';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
}
