import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
//import 'package:intl/intl.dart';

void main() => runApp(HealthBot());

class HealthBot extends StatefulWidget {
  @override
  _HealthBotState createState() => _HealthBotState();
}

class _HealthBotState extends State<HealthBot> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/health-chat-sioq-f623f6c4516f.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    // AIResponse aiResponse = await dialogflow.sendQuery("Your Query");
    //print('thing ${airesponse.getMessageResponse()}');
    print(aiResponse.getMessage());
    setState(() {
      messsages.insert(
          0, {"data": 0, "message": aiResponse.getMessage().toString()});
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HealthBot",
        ),
        backgroundColor: Color(0xFF083663),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage(
                'https://support.delta.chat/uploads/default/original/1X/768ded5ffbef90faa338761be1c5633d91cc35e3.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            // Divider(
            //   height: 5.0,
            //   color: Colors.blueGrey,
            // ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.blueGrey[300],
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: messageInsert,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration.collapsed(
                        //fillColor: Colors.black,
                        hintText: "Send your message",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  )),
                  Container(
                    color: Colors.blueGrey[300],
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Color(0xFF083663),
                        ),
                        onPressed: () {
                          if (messageInsert.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              messsages.insert(0,
                                  {"data": 1, "message": messageInsert.text});
                            });
                            response(messageInsert.text);
                            messageInsert.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Color(0xFF083663) : Color(0xFF08aaa0),
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /*CircleAvatar(
                  backgroundImage: AssetImage(
                      data == 0 ? "assets/bot.png" : "assets/user.png"),
                ),*/
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )),
    );
  }
}
