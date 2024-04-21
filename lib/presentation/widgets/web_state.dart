import 'package:flutter/material.dart';
import 'package:chatott/domain/entities/conversation.dart';

class WebState extends ChangeNotifier {
  int indexNav = 0;
  int indexChat = 0;
  Conversation conversation;
  
  WebState({required this.conversation});

  
  List indexInfo() {
    return [indexNav, indexChat];
  }

  void updateNav(int newNavIndex) {
    indexNav = newNavIndex;
    notifyListeners();
  }

  void updateChat(int newChatIndex) {
    indexChat = newChatIndex;
    notifyListeners();
  }

  void updateConversation(Conversation newConversation) {
    conversation = newConversation;
    notifyListeners();
  }
}

class WebInheritedWid extends InheritedNotifier<WebState> {
  WebInheritedWid({
    super.key,
    super.notifier,
    required super.child,
  });

  static WebInheritedWid? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WebInheritedWid>();
  }

  static WebInheritedWid of(BuildContext context) {
    //static function allow us to call the class without initialize it.
    final WebInheritedWid? result = maybeOf(context);
    assert(result != null, 'No Webnotifier found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(WebInheritedWid oldWidget) {
    // print("${notifier.indexNav} and ${oldWidget.notifier.indexNav}");
    return (notifier != oldWidget.notifier);
    // throw UnimplementedError();
  }
}