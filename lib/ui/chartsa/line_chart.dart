import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';







class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(child: Text('Graph',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // You can customize this action based on your navigation requirements
          },
        ),
      ),
      body: Center(
        child: SfCartesianChart(
          title: ChartTitle(text: 'Flutter Chart'),
          legend: Legend(isVisible: true),
          series: getDefaultData(),
          tooltipBehavior: _tooltipBehavior,
        ),
      ),
    );
  }

  static List<LineSeries<SalesData, num>> getDefaultData() {
    final bool isDataLabelVisible = true,
        isMarkerVisible = true,
        isTooltipVisible = true;
    double? lineWidth, markerWidth, markerHeight;
    final List<SalesData> chartData = <SalesData>[
      SalesData(DateTime(2005, 1, 1), 'India', 1.5, 21, 28, 680, 760),
      SalesData(DateTime(2006, 1, 1), 'China', 2.2, 24, 44, 550, 880),
      SalesData(DateTime(2007, 1, 1), 'USA', 3.32, 36, 48, 440, 788),
      SalesData(DateTime(2008, 1, 1), 'Japan', 4.56, 38, 50, 350, 560),
      SalesData(DateTime(2009, 1, 1), 'Russia', 5.87, 54, 66, 444, 566),
      SalesData(DateTime(2010, 1, 1), 'France', 6.8, 57, 78, 780, 650),
      SalesData(DateTime(2011, 1, 1), 'Germany', 8.5, 70, 84, 450, 800)
    ];

    return <LineSeries<SalesData, num>>[
      LineSeries<SalesData, num>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (SalesData sales, _) => sales.y,
        yValueMapper: (SalesData sales, _) => sales.y4,
        width: lineWidth ?? 2,
        markerSettings: MarkerSettings(
          isVisible: isMarkerVisible,
          height: markerWidth ?? 4,
          width: markerHeight ?? 4,
          shape: DataMarkerType.circle,
          borderWidth: 3,
          borderColor: Colors.red,
        ),
        dataLabelSettings: DataLabelSettings(
          isVisible: isDataLabelVisible,
          labelAlignment: ChartDataLabelAlignment.auto,
        ),
      ),
      LineSeries<SalesData, num>(
        enableTooltip: isTooltipVisible,
        dataSource: chartData,
        width: lineWidth ?? 2,
        xValueMapper: (SalesData sales, _) => sales.y,
        yValueMapper: (SalesData sales, _) => sales.y3,
        markerSettings: MarkerSettings(
          isVisible: isMarkerVisible,
          height: markerWidth ?? 4,
          width: markerHeight ?? 4,
          shape: DataMarkerType.circle,
          borderWidth: 3,
          borderColor: Colors.black,
        ),
        dataLabelSettings: DataLabelSettings(
          isVisible: isDataLabelVisible,
          labelAlignment: ChartDataLabelAlignment.auto,
        ),
      ),
    ];
  }
}
class SalesData {
  final DateTime year;
  final String country;
  final double y;
  final double y1;
  final double y2;
  final double y3;
  final double y4;

  SalesData(
      this.year, this.country, this.y, this.y1, this.y2, this.y3, this.y4);
}