import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';
import '../widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, fuelPriceModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: const Image(
                      image: AssetImage('images/index.jpeg')),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // const Text('I need a lift!'),
                // const Header('Discussion'),
                // GuestBook(addMessage: (message) => print(message)),

                Consumer<ApplicationState>(
                  builder: (context, appState, _) => AuthFunc(
                      loggedIn: appState.loggedIn,
                      signOut: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ),
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (appState.loggedIn) ...[
                        const Header('Discussion'),
                        GuestBook(
                          addMessage: (message) =>
                              appState.addMessageToGuestBook(message),
                          messages: appState.guestBookMessages, // new

                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
      }
    );
  }
}
