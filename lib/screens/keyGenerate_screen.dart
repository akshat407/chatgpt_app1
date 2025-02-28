import 'dart:async';

import 'package:chatgpt_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class GenerateKey extends StatefulWidget {

  @override
  State<GenerateKey> createState() => _GenerateKeyState();
}
class _GenerateKeyState extends State<GenerateKey> {

  TextEditingController pasteController = TextEditingController();
  String ApiKey = '';

  @override void initState() {
    getData();
  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ApiKey = prefs.getString('ApiKey')!;
    });
  }

  @override
  void dispose(){
    pasteController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: Drawer(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.0,
              ),
                Text(
                  'Generate a', style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'API Key', style: TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
                SizedBox(
                  height: 15.0,
                ),
                Text('To chat with me, get an API key from OpenAI. Simply click this button and follow the steps to generate a key. '
                    'Then enter the key in our app to start chatting',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: Container(
                //     padding: EdgeInsets.all(15.0),
                //     child: Text('To chat with me you should generate a API key'),
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             color: Colors.green,
                //             width: 2.0
                //         ),
                //         borderRadius: BorderRadius.circular(20.0),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.green,
                //           blurRadius: 10.0,
                //           offset: Offset(0, 10),
                //         )
                //       ],
                //       color: Colors.white
                //     ),
                //   ),
                // ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  fixedSize: Size(160, 40),
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  ),
                  elevation: 15.0,
                  shape: StadiumBorder(),
                ),
                onPressed: () async{
              //final url = 'https://google.com';

                  if(await launch('https://platform.openai.com/account/api-keys',
                  )){
                    debugPrint('succesfully');
                  }
                },
                child: Text(
                    'Create new key',
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
               Container(
                  child: Text(
                      'After copied your Api key paste and save it here',
                    style: TextStyle(fontSize: 12.0, color: Colors.black87),
                      ),
               ),
              SizedBox(
                height: 20.0,
              ),
              // Container(
              //   padding: EdgeInsets.all(15.0),
              //   child: Text('API Key'),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.deepOrange,
              //       width: 2.0
              //     ),
              //     borderRadius: BorderRadius.circular(20.0)
              //   ),
              // ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black87
                  ),
                  labelText: 'Paste your API Key',
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87
                  ),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final clipPaste =  await Clipboard.getData(Clipboard.kTextPlain);
                        final text = clipPaste == null ? '' : clipPaste.text!;
                        setState(() {
                          pasteController.text = text;
                        });
                      },
                      icon: Icon(
                        Icons.content_paste,
                        color: Colors.blueGrey,
                        size: 15.0,
                      )
                  ),
                ),
                controller: pasteController,
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  fixedSize: Size(160, 40),
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 15.0,
                  shape: StadiumBorder(),
                ),
                  onPressed: () async {
                    setState(() {
                      ApiKey = pasteController.text;
                      print(ApiKey);
                      Timer(
                          Duration(seconds: 3),
                              () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext) => ChatScreen())
                          )
                      );
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('ApiKey', ApiKey);
                    print(ApiKey);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  height: 90.0,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Success',style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Your OpenAI API key has been saved successfully. You wont need to enter it again in the future.',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                //SvgPicture.asset('images/bubbles.svg',
                                  // height: 48.0,
                                  //   width: 40.0,
                                  // color: Colors.red,
                                //),
                              ],
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          duration: Duration(seconds: 2),
                        ),
                    );
                  },
                child: Text(
                    'Save',
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
