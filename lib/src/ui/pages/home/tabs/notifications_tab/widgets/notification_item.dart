import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../../data/models/notifications.dart';
import '../../../../../../utils/font_styles.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text('data'),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.description,
                      style:
                          FontStyles.regular.copyWith(color: Colors.black87)),
                  Text(
                    timeago.format(notification.createdAt, locale: 'es'),
                    style: FontStyles.normal.copyWith(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
