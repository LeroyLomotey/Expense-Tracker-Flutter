import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class PieData {
  static List<PieChartSectionData> getSections(Map<String, double> m) {
    List<PieChartSectionData> sections = List.generate(m.length, (index) {
      PieChartSectionData section = PieChartSectionData(
          color: generateColor(),
          title: m.keys.elementAt(index),
          titleStyle: const TextStyle(
              fontSize: 18, color: Colors.black45, fontWeight: FontWeight.bold),
          value: m[m.keys.elementAt(index)],
          radius: 100);
      return section;
    });

    return sections;
  }

  static Color generateColor() {
    return Colors.accents[Random().nextInt(Colors.accents.length)].shade200;
  }
}
