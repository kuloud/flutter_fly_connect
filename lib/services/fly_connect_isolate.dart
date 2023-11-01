import 'package:flutter/services.dart';
import 'package:flutter_fly_connect/utils/logger.dart';

class ConnectService {
  final MethodChannel _channel =
      const MethodChannel('com.kuloud.fly.connect_channel');

  Future<String?> queryData() async {
    try {
      return await _channel.invokeMethod('queryData');
    } catch (e) {
      logger.e('Error querying data from flutter_my_tracker: $e');
      return null;
    }
  }
}
