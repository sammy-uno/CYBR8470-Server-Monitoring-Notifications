import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Profile.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/pages/notification_detail_page.dart';
import 'dart:async';

class ListNotificationsPage extends StatefulWidget {
  ListNotificationsPage({this.auth, this.userId, this.email, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final String email;

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static final Firestore db = Firestore.instance;
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  State<StatefulWidget> createState() => new _ListNotificationsPageState();
}

class _ListNotificationsPageState extends State<ListNotificationsPage> {
  bool applePayEnabled = false;
  bool googlePayEnabled = false;
  Profile profile;
  StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>.broadcast();

  List<Map<String, dynamic>> list = [];

  int i = 0;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
    _controller.stream.listen((p) => setState(() => list.insert(0, p)));

    ListNotificationsPage.firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        print(message["data"]);
        _controller.add(Map<String, dynamic>.from(message["data"]));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //showMessage("Notification", "$message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //showMessage("Notification", "$message");
      },
    );

  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.close();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Server Monitoring Notifications')),
      ),
      key: ListNotificationsPage.scaffoldKey,
      body: Center(
        child: list.length > 0
            ? ListView.builder(
          scrollDirection: Axis.vertical,
          //shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_, int index) {
            final Map<String, dynamic> notification = list[index];
            return new Container(
              padding: new EdgeInsets.all(3.0),
              child: Card(
                //elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading:
                    Text(
                      "${notification["severity"]}",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  title: Text(
                    "${notification["dateTime"]}",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${notification["summary"]}", style: TextStyle(color: Colors.black)),
                  //dense: true,
                  isThreeLine: true,

                    trailing:
                    Icon(Icons.keyboard_arrow_right, color: Colors.blueAccent, size: 30.0),
                  onTap: () => _navigateToDetail(notification),
                )
                ),
              );
          },
        )
            : Column(
          children: <Widget>[
            Center(
              heightFactor: 10,
              child: Text(
                'No Notifications Available',
                style: TextStyle(
                  //color: Colors.blueAccent,
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 60.0,
              child: DrawerHeader(
                child: Text(widget.email, style: TextStyle(fontSize: 20.0)),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(20.0),
              ),
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                _signOut();
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _navigateToDetail(notification) {
    print("detail called");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookDetailPage(
                notification: notification,
                profile: profile,
                auth: widget.auth,
                onSignedOut: widget.onSignedOut)));
  }

  void _getUserProfile() async {
    await ListNotificationsPage.db
        .collection('users')
        .document(widget.userId)
        .get()
        .then((snapshot) {
      profile = Profile(
          widget.userId,
          snapshot.data['email'],
          snapshot.data['firstName'],
          snapshot.data['lastName'],
          snapshot.data['address'],
          snapshot.data['city'],
          snapshot.data['state'],
          snapshot.data['zipcode']);
    });
  }
}
