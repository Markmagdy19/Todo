import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';


import '../utils/theme_provider.dart';

class SettingsPageUI extends StatefulWidget {
  const SettingsPageUI({super.key});


  @override
  _SettingPageUIState createState() => _SettingPageUIState();
}


  class _SettingPageUIState  extends State<SettingsPageUI> {
  bool valNotify1 = false;
  bool valNotify2 = false;
  bool valNotify3 = false;
  onChangeFunction1(bool newValue1){
    setState(() {
        valNotify1 =newValue1;
        Provider.of<ThemeProvider>(context, listen: false).setThemeMode(
            Theme.of(context).brightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light);
        // ThemeServices().switchModeTheme();
        // NotifyHelper().displayNotification;
      });



  }
  onChangeFunction2(bool newValue2){
    setState(() {
      valNotify2 =newValue2;
    });
  }
  onChangeFunction3(bool newValue3){
    setState(() {
      valNotify3 =newValue3;
    });
  }
  @override
    Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Settings",style: TextStyle(fontSize:22),),
        leading: IconButton(
          onPressed: () {},
          icon:const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children:  [
            const SizedBox(height: 40),
             const Row(
              children: [
                Icon(
                  Icons.person,
                  color:Colors.blue,
                ),
                SizedBox(width: 1),
                Text("Account",style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold ),)
              ],
            ),
            const Divider(height: 20,thickness: 1,),
            const SizedBox(height:10),
            buildAccountOption(context, "ChangePassword"),
            buildAccountOption(context, "content Settings"),
            buildAccountOption(context, "Social"),
            buildAccountOption(context, "Language"),
            buildAccountOption(context, "Privacy Security"),
            const SizedBox(height: 40),
             const Row(
              children: [
                Icon(Icons.volume_up_outlined,color:Colors.blue),
                SizedBox(width: 10,),
                Text("Notifications",style: TextStyle(fontSize:22,fontWeight:FontWeight.bold

                ))
              ],
            ),
            const Divider(height:20 ,thickness: 1,),
            const SizedBox(height:10),
            buildNotificationOption("DarkMode", valNotify1, onChangeFunction1),
            buildNotificationOption("Account Active", valNotify2, onChangeFunction2),
            buildNotificationOption("Opportunity", valNotify3, onChangeFunction3),
            const SizedBox(height:50 ),
             Center(
              child: OutlinedButton(
                style:OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
                child:  const Text("Sign Out",style:TextStyle(
                  fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.black
                )),
              ),
            )

          ],
        ),
      )

    );

  }
  Padding buildNotificationOption(String title ,bool value,Function onChangeMethod){
return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20 ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,style :TextStyle(
        fontSize:20,
        fontWeight: FontWeight.w500,
        color: Colors.grey[600]
      )),
      Transform.scale(scale: 0.7,
      child:CupertinoSwitch(
        activeColor: Colors.blue,
        trackColor:Colors.grey ,
        value: value,
        onChanged: (bool newValue){
          onChangeMethod(newValue);
          
        },
      ) ,)
    ],
  )

);
  }


  GestureDetector buildAccountOption(BuildContext context,String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context,builder: (BuildContext context){
         return AlertDialog(
           title:Text(title),
           content:  const Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Text("English"),
               Text("Arabic"),
             ],
           ),
           actions: [
             TextButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 child:const Text("close")

             )
           ]
         );
        });

        },
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical:8 ,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style:  TextStyle(
              fontSize:20 ,
              fontWeight:FontWeight.w500 ,
              color: Colors.grey[600]
            ),),
            const Icon(Icons.arrow_forward_ios,color: Colors.grey),
          ],
        )
      ),
    );
  }
  }
