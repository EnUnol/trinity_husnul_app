import 'dart:convert';
import 'package:flutter/services.dart';

class DataProvider {
  Future<Map<String, dynamic>> fetchData(String jsonFilePath) async {
    try {
      // Load the JSON file using rootBundle
      String jsonString = await rootBundle.loadString(jsonFilePath);

      // Decode the JSON string
      return json.decode(jsonString);
    } catch (e) {
      // Handle errors (e.g., file not found, JSON decoding error)
      print('Error loading JSON file: $e');
      return {};
    }
  }

  Future<void> overwriteData(
      String jsonFilePath, Map<String, dynamic> newData) async {
    try {
      // Encode the new data to JSON string
      String jsonString = json.encode(newData);

      // Evict the cache for the specified file
      rootBundle.evict(jsonFilePath);

      // Load the updated JSON string (this will also cache it)
      await rootBundle.loadString(jsonFilePath);
    } catch (e) {
      // Handle errors (e.g., file not found, JSON encoding error)
      print('Error overwriting JSON file: $e');
    }
  }
}
