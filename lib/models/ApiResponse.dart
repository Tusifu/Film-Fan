class APIResponse<T> {
  late T? data;
  late bool error;
  late String errorMessage;

  APIResponse({this.data, this.error = false, this.errorMessage = ''});
}
