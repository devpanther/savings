import 'package:flutter/material.dart';
import 'package:savings/models/data.dart';
import 'package:savings/constants.dart';
import 'package:hexcolor/hexcolor.dart';


class RecentChats extends StatelessWidget {
  TextEditingController _sendMessageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: getBody(),
        ),
      ),
    );
  }
  Widget getBottom(){
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: grey.withOpacity(0.2)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100,
              child: Row(
                children: <Widget>[
              Icon(Icons.add_circle,size: 35,color: primary,),
              SizedBox(width: 15,),
              Icon(Icons.camera_alt,size: 35,color: primary,),
              SizedBox(width: 15,),
              Icon(Icons.photo,size: 35,color: primary,),
              SizedBox(width: 15,),
              Icon(Icons.keyboard_voice,size: 35,color: primary,),
                ],
              ),
            ),
            Container(
              width: 100,
              child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextField(
                      cursorColor: black,
                      controller: _sendMessageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Aa",
                        suffixIcon: Icon(Icons.face,color: primary,size: 35,)
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Icon(Icons.thumb_up,size: 35,color: primary,),
              ],
            ),
            ),
            
            
            
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    
    return ListView(
      padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 80),
      children: List.generate(messages.length, (index){
        return ChatBubble(isMe: messages[index]['isMe'],messageType: messages[index]['messageType'],message: messages[index]['message'],profileImg: messages[index]['profileImg']);
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  const ChatBubble({
    Key key, this.isMe, this.profileImg, this.message, this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isMe){
      return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
                          child: Container(
                decoration: BoxDecoration(
                  color: Hexcolor("0066F5"),
                  borderRadius: getMessageType(messageType) 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: white,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding:  EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                            profileImg),
                        fit: BoxFit.cover)),
              ),
            SizedBox(
              width: 15,
            ),
            Flexible(
                          child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.1),
                  borderRadius: getMessageType(messageType) 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: black,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    
  }
  getMessageType(messageType){
    if(isMe){
      // start message
      if(messageType == 1){
        return BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // middle message
      else if(messageType == 2){
        return BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // end message
      else if(messageType == 3){
        return BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // standalone message
      else{
        return BorderRadius.all(Radius.circular(30));
      }
    }
    // for sender bubble
    else{
      // start message
        if(messageType == 1){
          return BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // middle message
        else if(messageType == 2){
          return BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // end message
        else if(messageType == 3){
          return BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // standalone message
        else{
          return BorderRadius.all(Radius.circular(30));
        }
    }
    
    
  }
}
