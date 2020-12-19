import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Profile.dart';
import 'package:flutter_app/services/authentication.dart';

enum ApplePayStatus { success, fail, unknown }

class BookDetailPage extends StatefulWidget {
  final Map<String, dynamic> notification;
  final Profile profile;
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  BookDetailPage(
      {this.notification, this.profile, this.auth, this.onSignedOut});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final _formKey = new GlobalKey<FormState>();
  String _resolution;
  String _errorMessage;
  bool _isLoading;

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Detail Page'),
      ),
      key: BookDetailPage.scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Center(
                child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder(
                      horizontalInside: BorderSide(
                          width: 1,
                          color: Colors.blue,
                          style: BorderStyle.solid)),
                  columnWidths: {
                    0: FlexColumnWidth(10),
                    1: FlexColumnWidth(15)
                  },
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Colors.red),
                        children: [
                          Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(2.0),
                              child: Text('Severity',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                            ),
                          ]),
                          Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                '${widget.notification["severity"]}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            )
                          ]),
                        ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0),
                          child: Text('Timestamp',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                      ]),
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            '${widget.notification["dateTime"]}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0),
                          child: Text('Server Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                      ]),
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            '${widget.notification["serverName"]}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0),
                          child: Text('Detail',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                      ]),
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                              '${widget.notification["detail"]}',
                              style: TextStyle(fontSize: 18.0)),
                        ),
                      ]),
                    ]),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Form(
                  key: _formKey,
                  child: new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _showActionInput(),
                      _showPrimaryButton(context),
                      _showErrorMessage(),
                    ],
                  ),
                ),
              )
            ]))),
      ),

      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 60.0,
              child: DrawerHeader(
                child: Text(widget.profile.email,
                    style: TextStyle(fontSize: 20.0)),
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
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showPrimaryButton(context) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.blue,
              child: new Text('Submit',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: _validateAndSubmit),
        ));
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget _snackBar(String title) {
    return SnackBar(
        duration: const Duration(seconds: 10), content: Text(title));
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      try {
        // Send the request to FCM
        print('Resolution sent');
        BookDetailPage.scaffoldKey.currentState.showSnackBar(_snackBar(
            'Ticket has been updated and sent to the resolution queue'));
        //Navigator.pop(context);
        new Timer(const Duration(seconds: 5), () {
          Navigator.pop(context);
        });
      } catch (e) {
        BookDetailPage.scaffoldKey.currentState
            .showSnackBar(_snackBar("There was an error updating the ticket"));
      }
    }
  }

  Widget _showActionInput() {
    return TextFormField(
      minLines: 2,
      maxLines: 5,
      style: TextStyle(fontSize: 18.0),
      autofocus: true,
      decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Resolution',
          hintText: 'Ticket Resolution',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      validator: (value) =>
          value.isEmpty ? 'Ticket resolution can\'t be empty' : null,
      onSaved: (value) => _resolution = value.trim(),
    );
  }

}
