// Package Imports
import 'dart:convert';

// Package imports
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? 0;
   
    return value;
  }

  save(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
   
  }

  saveObject(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    
  }

  readObject(key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.get(key));
  }

  remove(key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
