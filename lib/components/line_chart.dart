import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LineChartSample2 extends StatefulWidget {
   LineChartSample2({super.key,required this.score});
  List<double> score;
  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [Colors.green, Color(0xff04657A)];

  bool showAvg = false;
  int maxX = 10;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: 360.w,
          height: 300.h,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,right: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(
      double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.nunito(
      fontWeight: FontWeight.w600,
      fontSize: 10.sp,
    );
    int index = value.toInt() - 1;
    Widget text;
    if (index >= 0 && index < widget.score.length-1) {
      text = Text('${index + 1}', style: style);
    } else {
      text = Text('', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.nunito(
      fontWeight: FontWeight.w600,
      fontSize: 8.sp,
    );
    String text;
    switch (value*10.toInt()) {
      case 10:
        text = '10%';
        break;
      case 20:
        text = '20%';
        break;
      case 30:
        text = '30%';
        break;
      case 40:
        text = '40%';
        break;
      case 50:
        text = '50%';
        break;
      case 60:
        text = '60%';
        break;
      case 70:
        text = '70%';
        break;
      case 80:
        text = '80%';
        break;
      case 90:
        text = '90%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    int maxY = widget.score.length;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black12.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.black12.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black12),
      ),
      minX: 0,
      maxX: maxY-1.toDouble(),
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: widget.score.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          curveSmoothness: 0.05,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

}
