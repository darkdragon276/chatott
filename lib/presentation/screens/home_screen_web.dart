import 'package:chatott/presentation/widgets/top_bar.dart';
import 'package:chatott/presentation/widgets/chat_card.dart';
import 'package:chatott/presentation/pages/message_page.dart';
import 'package:chatott/presentation/pages/conversation_info_web_page.dart';
import 'package:chatott/presentation/pages/nav_function_web_page.dart';
import 'package:chatott/presentation/screens/chat_box_screen.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:chatott/presentation/widgets/nav_web_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  // int _index = 0;
  int oldConverID = 1;
  var chatboxWidget = ChatBoxScreen(conversationId: 1, isMobile: false,);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WebInheritedWid(
          notifier: WebState(conversationID: oldConverID),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // trying to build the ChatBoxScreen only once. Because when resizing the windows, build function will be called
                // multiple time, and if we build ChatBoxScreen everytime the build function re-run, we will make multiple
                // connection to the database, and in some cases the app will break due to timeout, failed connection!
            if (WebInheritedWid.of(context).notifier!.conversationID != oldConverID) {
              chatboxWidget = ChatBoxScreen(
                  conversationId:
                      WebInheritedWid.of(context).notifier!.conversationID,
                      isMobile: false,);
              oldConverID =
                  WebInheritedWid.of(context).notifier!.conversationID;
            } else {
              chatboxWidget = chatboxWidget;
            }
            print("old id $oldConverID - true  id: ${WebInheritedWid.of(context).notifier!.conversationID}");
            if (constraints.maxWidth > 1200) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    NavFunction(),
                    Expanded(
                      child: chatboxWidget,
                    ),
                    SizedBox(
                      width: 350,
                      child: ConversationInfo(),
                    )

                    // NavBar(),
                  ]);
            } else if (constraints.maxWidth > 800) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    NavFunction(),
                    Expanded(
                      child: chatboxWidget,
                    ),

                    // NavBar(),
                  ]);
            } else if (constraints.maxWidth > 550) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    Expanded(
                      child: chatboxWidget,
                    ),

                    // NavBar(),
                  ]);
            } else {
              return Placeholder();
            }
          })),
    ));
  }
}