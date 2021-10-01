import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/notifications.dart';
import '../../data/repositories/websocket_repository.dart';
import '../../helpers/get.dart';

class NotificationsController extends ChangeNotifier {
  final _wsRepository = Get.i.find<WebsocketRepository>();

  late StreamSubscription<AppNotification> _subscription;
  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;
  StreamController<List<AppNotification>> _streamController =
      StreamController.broadcast();
  Stream<List<AppNotification>> get onNotificationsChanged =>
      _streamController.stream;

  NotificationsController() {
    _subscription =
        _wsRepository.onNotification.listen(_onNotificationListener);
  }

  void _onNotificationListener(AppNotification notification) {
    _notifications = [notification, ...notifications];
    _streamController.sink.add(_notifications);
    notifyListeners();
  }

  void clear() {
    _notifications = [];
  }

  @override
  void dispose() {
    _streamController.close();
    _subscription.cancel();
    super.dispose();
  }
}
