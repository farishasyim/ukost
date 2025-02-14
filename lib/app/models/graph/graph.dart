class Graph {
  String? xAxis;
  int? yAxis;

  Graph({this.xAxis, this.yAxis});

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        xAxis: json["x_axis"],
        yAxis: json["y_axis"],
      );
}
