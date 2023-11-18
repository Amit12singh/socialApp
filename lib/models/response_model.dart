class BoolResponseModel {
  String message;
  bool success;
  bool isError;

  BoolResponseModel(
      {required this.message, required this.success, this.isError = false});
}
