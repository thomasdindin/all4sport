import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkState extends ChangeNotifier {
  static final NetworkState _instance = NetworkState._internal();

  bool _isOnline = false;
  bool get isOnline => _isOnline;


  NetworkState._internal() {
    _initializeConnectivity();
  }

  static NetworkState getInstance() {
    return _instance;
  }

  Future<void> _initializeConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    bool isOnline = result != ConnectivityResult.none;
    if (_isOnline != isOnline) {
      _isOnline = isOnline;
      notifyListeners();
    }
  }
}
