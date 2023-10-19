class PaginationModel {
  int? page;
  int? perPage;
  String? search;

  PaginationModel({this.page = 1, this.perPage = 20, this.search = ''}) {}
}
