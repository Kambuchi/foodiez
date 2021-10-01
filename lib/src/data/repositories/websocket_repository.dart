import '../models/notifications.dart';

abstract class WebsocketRepository{
  Future<void> connect(String uri);
  Future<void> disconnect();
  Stream<AppNotification> get onNotification;
}