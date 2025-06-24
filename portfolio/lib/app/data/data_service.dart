import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';

class DataService {
  Future<PortfolioData> loadPortfolioData() async {
    final String jsonString = await rootBundle.loadString('assets/data/portfolio_data.json');
    debugPrint('--- RAW JSON DATA ---\n$jsonString\n--- END RAW JSON DATA ---');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return PortfolioData.fromJson(jsonMap);
  }
}
