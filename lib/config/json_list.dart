class JsonList<T> {
  List<T> data = [];
  JsonList(Map<String, dynamic> response,
      T Function(Map<String, dynamic> e) callback,
      {String key = "data"}) {
    if (response.containsKey(key)) {
      data = List<T>.from(response[key].map((e) => callback(e)));
    }
  }
}
