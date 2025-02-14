abstract class DataState<T> {
  final T? data;
  final String? error;

  const DataState({this.data, this.error});
}

class DataSucess<T> extends DataState<T> {
  const DataSucess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String error) : super(error: error);
}
