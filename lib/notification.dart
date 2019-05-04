import 'package:flutter/material.dart';
import 'package:onesignal/onesignal.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => new _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _debugLabelString = "";
  String _emailAddress;
  String _externalUserId;
  bool _enableConsentButton = false;

  bool _requireConsent = true;


  @override
  void initState() {
    super.initState();
    initSigState();
  }
  
  Future<void> initSigState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      this.setState(() {
        _debugLabelString =
        "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
            (OSEmailSubscriptionStateChanges changes) {
          print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
        });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("b6570921-da05-4edd-97b1-db7621ebf744", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });
  }

  void _handleGetPermissionSubscriptionState() {
    print("Getting permissionSubscriptionState");
    OneSignal.shared.getPermissionSubscriptionState().then((status) {
      this.setState(() {
        _debugLabelString = status.jsonRepresentation();
      });
    });
  }

  void _handleConsent() {
    print("Setting consent to true");
    OneSignal.shared.consentGranted(true);

    print("Setting state");
    this.setState(() {
      _enableConsentButton = false;
    });
  }


  void _handleSendNotification() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "this is a test from OneSignal's Flutter SDK",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);

    this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    });
  }

  void _handleSendSilentNotification() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;

    var notification = OSCreateNotification.silentNotification(
        playerIds: [playerId], additionalData: {'test': 'value'});

    var response = await OneSignal.shared.postNotification(notification);

    this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Notification'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: new Table (
          children: [
            new TableRow(children: [
              new OneSignalButton("Subscribe", _handleConsent,
                  _enableConsentButton)
            ]),
            new TableRow(children: [
              new OneSignalButton("Post Notification",
                  _handleSendNotification, !_enableConsentButton)
            ]),
            new TableRow(children: [
              new OneSignalButton(
                  "Print Permission Subscription State",
                  _handleGetPermissionSubscriptionState,
                  !_enableConsentButton)
            ]),
          ],
        ),
      ),
    );
  }
}

typedef void OnButtonPressed();

class OneSignalButton extends StatefulWidget {
  final String title;
  final OnButtonPressed onPressed;
  final bool enabled;

  OneSignalButton(this.title, this.onPressed, this.enabled);

  State<StatefulWidget> createState() => new OneSignalButtonState();
}

class OneSignalButtonState extends State<OneSignalButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Table(
      children: [
        new TableRow(children: [
          new FlatButton(
            disabledColor: Color.fromARGB(180, 212, 86, 83),
            disabledTextColor: Colors.white,
            color: Color.fromARGB(255, 212, 86, 83),
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: new Text(widget.title),
            onPressed: widget.enabled ? widget.onPressed : null,
          )
        ]),
        new TableRow(children: [
          Container(
            height: 8.0,
          )
        ]),
      ],
    );
  }
}