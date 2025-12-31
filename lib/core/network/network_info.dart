import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class networkinfoimpl implements NetworkInfo {
  final InternetConnection connectionchecker;

  networkinfoimpl({required this.connectionchecker});
  @override
  Future<bool> get isConnected => connectionchecker.hasInternetAccess;
}
