import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final Widget child;

  const NotificationPage({Key key, this.child}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purpleAccent,
        child: Center(child: Text("Notification Page")));
  }
}
