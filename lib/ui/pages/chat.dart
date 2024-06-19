import 'package:chatt/ui/widgets/Chat_messages.dart';
import 'package:chatt/ui/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title:  Text(S.of(context).Hospital_Group),
          actions: [
            IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            },
              icon: const Icon(Icons.exit_to_app),

              color: Theme.of(context).colorScheme.primary,
            ),

          ],
        ),
        body:const Column(
          children: [

            Expanded(child: chatMessages(),
            ),
            NewMessage(),
          ],
        ));

  }




}