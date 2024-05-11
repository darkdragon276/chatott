import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/presentation/pages/conversation_info_web_page.dart';
import 'package:chatott/presentation/pages/directory_web_page.dart';
import 'package:chatott/presentation/pages/nav_bar_web_page.dart';
import 'package:chatott/presentation/pages/nav_function_web_page.dart';
import 'package:chatott/presentation/screens/chat_box_screen.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:flutter/material.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  // int _index = 0;
  Conversation oldConversation = Conversation.empty;
  var oldIndexNav = 0;
  var oldIndexChat = 0;
  var chatboxWidget = ChatBoxScreen(
    conversationId: 1,
    conversationName: "No one",
    isMobile: false,
  );
  var infoWidget = ConversationInfo(
    conversation: Conversation.empty,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WebInheritedWid(
          notifier: WebState(
              conversation: oldConversation,
              indexNav: oldIndexNav,
              indexChat: oldIndexChat),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            // trying to build the ChatBoxScreen only once. Because when resizing the windows, build function will be called
            // multiple time, and if we build ChatBoxScreen everytime the build function re-run, we will make multiple
            // connection to the database, and in some cases the app will break due to timeout, failed connection!
            if (WebInheritedWid.of(context).notifier!.conversation.id !=
                oldConversation.id) {
              chatboxWidget = ChatBoxScreen(
                conversationId:
                    WebInheritedWid.of(context).notifier!.conversation.id,
                conversationName: WebInheritedWid.of(context).notifier!.conversation.listUsername.join(", "),
                isMobile: false,
              );
              infoWidget = ConversationInfo(
                  conversation:
                      WebInheritedWid.of(context).notifier!.conversation);
              oldConversation =
                  WebInheritedWid.of(context).notifier!.conversation;
              // print("Changed");
            } else {
              // print("NO changed");
              chatboxWidget = chatboxWidget;
              infoWidget = infoWidget;
            }
            // print("old id ${oldConversation.id} - true  id: ${WebInheritedWid.of(context).notifier!.conversation.id}");
            if (oldIndexNav != WebInheritedWid.of(context).notifier!.indexNav) {
              oldIndexNav = WebInheritedWid.of(context).notifier!.indexNav;
            }
            if (oldIndexChat !=
                WebInheritedWid.of(context).notifier!.indexChat) {
              oldIndexChat = WebInheritedWid.of(context).notifier!.indexChat;
            }
            if (constraints.maxWidth > 1200) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    NavFunction(
                      isMobile: false,
                    ),
                    WebInheritedWid.of(context).notifier!.indexNav == 0
                        ? Expanded(
                            child: oldConversation == Conversation.empty
                                ? DummyWelcomePage()
                                : chatboxWidget,
                          )
                        : Expanded(
                            child: DirectoryWeb(),
                          ),
                    (oldConversation == Conversation.empty) ||
                            (WebInheritedWid.of(context).notifier!.indexNav !=
                                0)
                        ? SizedBox(
                            width: 1,
                          )
                        : SizedBox(
                            width: 350,
                            child: infoWidget,
                          )

                    // NavBar(),
                  ]);
            } else if (constraints.maxWidth > 800) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    NavFunction(
                      isMobile: false,
                    ),
                    WebInheritedWid.of(context).notifier!.indexNav == 0
                        ? Expanded(
                            child: oldConversation == Conversation.empty
                                ? DummyWelcomePage()
                                : chatboxWidget,
                          )
                        : Expanded(child: DirectoryWeb()),

                    // NavBar(),
                  ]);
            } else if (constraints.maxWidth > 550) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    WebInheritedWid.of(context).notifier!.indexNav == 0
                        ? Expanded(
                            child: NavFunction(
                              isMobile: true,
                            ),
                          )
                        : Expanded(child: DirectoryWeb()),

                    // NavBar(),
                  ]);
            } else {
              return Placeholder();
            }
          })),
    ));
  }
}

class DummyWelcomePage extends StatelessWidget {
  const DummyWelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(
            255, 173, 205, 255),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 0),
            child: Text(
              "Chào mừng đến với Zola!",
              softWrap: true,
              style: TextStyle(
                  fontSize: 100,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
  }
}


