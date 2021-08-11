import 'package:flutter/material.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/geo_location.dart';
import 'package:moengage_flutter/properties.dart';
import 'package:moengage_flutter/app_status.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/inbox_message.dart';
import 'package:moengage_inbox/moengage_inbox.dart';
import 'package:moengage_flutter/push_campaign.dart';
import 'package:moengage_flutter/inapp_campaign.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  final MoEngageFlutter _moengagePlugin = MoEngageFlutter();
  final MoEngageInbox _moEngageInbox = MoEngageInbox();

  void _onPushClick(PushCampaign message) {
    print("This is a push click callback from native to flutter. Payload " +
        message.toString());
  }

  void _onInAppClick(InAppCampaign message) {
    print("This is a inapp click callback from native to flutter. Payload " +
        message.toString());
  }

  void _onInAppShown(InAppCampaign message) {
    print("This is a callback on inapp shown from native to flutter. Payload " +
        message.toString());
  }

  void _onInAppDismiss(InAppCampaign message) {
    print("This is a callback on inapp dismiss from native to flutter. Payload " +
        message.toString());
  }

  void _onInAppCustomAction(InAppCampaign message) {
    print("This is a callback on inapp custom action from native to flutter. Payload " +
        message.toString());
  }

  void _onInAppSelfHandle(InAppCampaign message) {
    print("This is a callback on inapp self handle from native to flutter. Payload " +
        message.toString());
  }


  @override
  void initState() {
    super.initState();

    //Initialize MoEngage SDK
    _moengagePlugin.initialise();

    _moengagePlugin.setUpPushCallbacks(_onPushClick);

    _moengagePlugin.setUpInAppCallbacks(
        onInAppClick: _onInAppClick,
        onInAppShown: _onInAppShown,
        onInAppDismiss: _onInAppDismiss,
        onInAppCustomAction: _onInAppCustomAction,
        onInAppSelfHandle: _onInAppSelfHandle
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MoEngage SDK'),
        ),
        body: new Center(
          child: new ListView(
            children: ListTile.divideTiles(context: context, tiles: [
              new ListTile(
                  title: new Text("Track Event"),
                  onTap: () {
                    var details = MoEProperties();
                    details
                        .addAttribute("attrName1", "attrVal")
                        .addAttribute("attrName2", false)
                        .addAttribute("attrName3", 123563563)
                        .setNonInteractiveEvent()
                        .addAttribute(
                        "location1", new MoEGeoLocation(12.1, 77.18));
                    _moengagePlugin.trackEvent('event flutter 01', details);
                  }),
              new ListTile(
                  title: new Text("Track Interactive Event with Attributes"),
                  onTap: () {
                    var details = MoEProperties();
                    details
                        .addAttribute("attrName1", "attrVal")
                        .addAttribute("attrName2", false)
                        .addAttribute("attrName3", 123563563)
                        .addAttribute(
                        "location1", new MoEGeoLocation(12.1, 77.18));
                        _moengagePlugin.trackEvent(
                        'interactive event flutter 01', details);
                  }),
              new ListTile(
                  title: Text("Track Only Event"),
                  onTap: () {
                    _moengagePlugin.trackEvent("trackOnlyEventName");
                    _moengagePlugin.trackEvent("testEvent", MoEProperties());
                  }),
              new ListTile(
                  title: new Text("Set Unique Id"),
                  onTap: () {
                    _moengagePlugin.setUniqueId('shivam@moengage.com');
                  }),
              new ListTile(
                  title: new Text("Set UserName"),
                  onTap: () {
                    _moengagePlugin.setUserName('Shivam Agrawal');
                  }),
              new ListTile(
                  title: new Text("Set FirstName"),
                  onTap: () {
                    _moengagePlugin.setFirstName("Shivam");
                  }),
              new ListTile(
                  title: new Text("Set LastName"),
                  onTap: () {
                    _moengagePlugin.setLastName("Agrawal");
                  }),
              new ListTile(
                  title: new Text("Set Email-Id"),
                  onTap: () {
                    _moengagePlugin.setEmail("shivam.agrawal@moengage.com");
                  }),
              new ListTile(
                  title: new Text("Set Phone Number"),
                  onTap: () {
                    _moengagePlugin.setPhoneNumber("1234567890");
                  }),
              new ListTile(
                title: Text("Set Custom User Attributes"),
                onTap: () {
                  _moengagePlugin.setUserAttribute("userAttr-bool", true);
                  _moengagePlugin.setUserAttribute("userAttr-int", 1443322);
                  _moengagePlugin.setUserAttribute("userAttr-Double", 45.4567);
                  _moengagePlugin.setUserAttribute(
                      "userAttr-String", "This is a string");
                },
              ),
              new ListTile(
                  title: Text("App Status - Install"),
                  onTap: () {
                    _moengagePlugin.setAppStatus(MoEAppStatus.install);
                  }),
              new ListTile(
                  title: Text("App Status - Update"),
                  onTap: () {
                    _moengagePlugin.setAppStatus(MoEAppStatus.update);
                  }),
              new ListTile(
                  title: Text("Show InApp"),
                  onTap: () {
                    _moengagePlugin.showInApp();
                  }),
              new ListTile(
                  title: Text("Show Self Handled InApp"),
                  onTap: () {
                    _moengagePlugin.getSelfHandledInApp();
                  }),
              new ListTile(
                title: Text("Logout"),
                onTap: () {
                  _moengagePlugin.logout();
                },
              ),
              new ListTile(
                title: Text("Un Clicked Count"),
                onTap: () async {
                  int count = await _moEngageInbox.getUnClickedCount();
                  print("MoEngage Un-clicked Count " + count.toString());
                },
              ),
              new ListTile(
                title: Text("Get all messages"),
                onTap: () async {
                  InboxData? data = await _moEngageInbox.fetchAllMessages();
                  if (data != null && data.messages.length > 0) {
                    InboxMessage message = data.messages[0];
                    _moEngageInbox.trackMessageClicked(message);
                    _moEngageInbox.deleteMessage(message);

                    for (final message in data.messages) {
                      print(message.toString());
                    }
                  } else {
//                    print("Inbox messages: " + data?.toString());
                  }
                },
              ),
            ]).toList(),
          ),
        ),
      ),
    );
  }
  
}