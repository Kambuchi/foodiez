import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/notification_item.dart';
import '../../../../global_controller/notifications_controller.dart';

class NotificationsTab extends StatefulWidget {
  NotificationsTab({Key? key}) : super(key: key);

  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationsController>();
    super.build(context);
    return ListView.builder(
      itemBuilder: (_, index) {
        final notification = controller.notifications[index];
        return NotificationItem(notification: notification);
      },
      itemCount: controller.notifications.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
