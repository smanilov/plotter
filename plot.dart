import "dart:io";
import "dart:math";
import "dart:async";

class Region {
  double lowerBound;
  double upperBound;
  int count;

  double length() => upperBound - lowerBound;
  double middle() => (upperBound + lowerBound) / 2;
  bool contains(num x) => x > lowerBound && x <= upperBound;
}

List<Region> buildRegions(List<double> bounds) {
  var result = new List<Region>();
  for (int i = 1; i < bounds.length; ++i) {
    var r = new Region();
    r.lowerBound = bounds[i - 1];
    r.upperBound = bounds[i];
    r.count = 0;
    result.add(r);
  }
  return result;
}

main() async {
  List<String> lines = new File('data').readAsLinesSync();
  List<int> data = lines.map(int.parse);

  double mu = mean(data);
  double sigma = stdev(data, mu);
  double max_ = data.reduce(max) + 1;
  // print(mu);
  // print(sigma);
  // Using [Scott, 1979] for optimal bin size:
  var binWidth = 3.49 * sigma * pow(data.length, -1/3);
  var numBins = (max_ / binWidth).ceil() + 1;
  var bounds = new List<double>.generate(numBins, (x) => (x * binWidth));
  bounds = bounds.where((x) => x > 0).toList();
  bounds.insert(0, 0);
  bounds.add(max_);

  var regions = buildRegions(bounds);
  regions.forEach((r) => r.count = data.where((x) => r.contains(x)).length);
  var max_count = regions.map((r) => r.count).reduce(max);
  var boxesLines = regions.map((r) => "${r.middle()} ${r.count} ${r.length()}");

  var writes = new List<Future>();
  writes.add(new File('boxes').writeAsString(boxesLines.join("\n")));
  writes.add(new File('mu-sigma-max').writeAsString("$mu\n$sigma\n$max_count"));
  Future.wait(writes);
}

double mean(List<int> data) {
  double sum = data.reduce((x, y) => x + y);
  return sum / data.length;
}

double stdev(List<int> data, [double mu]) {
  if (mu == null) mu = mean(data);
  double variance =
      data.map((x) => x - mu).map((x) => x * x).reduce((x, y) => x + y);
  return sqrt(variance / (data.length - 1));
}
