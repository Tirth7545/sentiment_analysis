import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sentiment_analysis/model/model.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_config/flutter_config.dart';
//Excellent - lottie6
// Good - lottie8
// Neutral - lottie5
// Poor - lottie 3
// Worst -lottie1
// invalid_content - inv

class Result extends StatefulWidget {
  String text;

  Result(this.text);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Post post;

  var url = FlutterConfig.get('API_URL').toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  Future getData() async {
    http.Response response = await http.get('url');
    print(response.statusCode);
    var data = jsonDecode(response.body);
    post.fromMap(data);
  }

  Future postData(String message) async {
    print(message);
      print("Message print");
    /*This is Starts TO handle \n or New line for text to json parse*/
    var listofnewline = message.split('\n');
    print('$listofnewline');
    message = '';
    for (int i = 0; i < listofnewline.length; i++) {
      var comman = listofnewline[i].toString();

      if (listofnewline[i].contains('\\')) {
        print("ys a \" conain ");
        var checkvar = listofnewline[i].split('\\');
        print("Checkvar is $checkvar");
        var checkvarmsg = checkvar[0];
        for (int j = 1; j < checkvar.length; j++) {
          checkvarmsg = checkvarmsg + '\\\\' + checkvar[j].toString();
        }
        listofnewline[i] = checkvarmsg;
        print("This is checkvar message $checkvarmsg");
      }

      if (comman.contains('"')) {
        print("ys a \" conain ");
        var checkvar = comman.split('"');
        print("Checkvar is $checkvar");
        var checkvarmsg = checkvar[0];
        for (int j = 1; j < checkvar.length; j++) {
          checkvarmsg = checkvarmsg + "\\" + '\"' + checkvar[j].toString();
        }
        comman = checkvarmsg;
        listofnewline[i] = comman;
        print("This is checkvar message $checkvarmsg");
      }

//

      message = message + '\\n' + listofnewline[i].toString();
    }
    print("This is Opinion");
    print(message);
    /*This is Ends TO handle \n or New line for text to json parse*/

    var token = FlutterConfig.get('API_KEY').toString();
    http.Response response = await http.post(url,
        headers: headers, body: jsonEncode(Post('$message', '$token').toMap()));
    print("Here Is Status Code");
    print(response.statusCode);
    print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Sentiment",style:TextStyle(fontWeight: FontWeight.w300),),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Container(
          child: FutureBuilder(
            future: postData(widget.text),
            builder: (context, snapshot) {
              print(widget.text);
              print("THis t text");
              if (snapshot.connectionState == ConnectionState.done) {
                print("Print");
                print(snapshot.data.toString());
                var final_result = snapshot.data.toString();
//                final_result='Worst';
                print("This is FInal Reult ${final_result}");
                if (final_result == "\"Excellent\"") {
                  print("Int The Excellent");
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 300,
                          width: 200,
                          child: Lottie.asset('assets/lottie6.json'),
                        ),
                        Text("Excellent",style: Theme.of(context).textTheme.body1,)
                      ],
                    ),
                  );
                } else if (final_result == '\"Good\"') {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 300,
                          width: 200,
                          child: Lottie.asset('assets/lottie8.json'),
                        ),
                        Text("Good",style: Theme.of(context).textTheme.body1,)
                      ],
                    ),
                  );
                } else
                if (final_result == '\"Neutral\"') {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 300,
                          width: 200,
                          child: Lottie.asset('assets/lottie5.json'),
                        ),
                        Text("Neutral",style: Theme.of(context).textTheme.body1,)
                      ],
                    ),
                  );
                } else
                if (final_result == '\"Poor\"') {
                  return Center(
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 300,
                          width: 150,
                          child: Lottie.asset('assets/lottie3.json'),
                        ),

                        Text("Poor",style: Theme.of(context).textTheme.body1,)
                      ],
                    ),
                  );
                } else
                if (final_result == '\"Worst\"') {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 300,
                          width: 150,
                          child: Lottie.asset('assets/lottie1.json'),
                        ),

                        Text("Worst",style: Theme.of(context).textTheme.body1,)
                      ],
                    ),
                  );
                }
                else {
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 300,
                            width: 300,
                            child: Lottie.asset('assets/inv.json'),
                          ),
                          Text("Invalid Content")
                        ],
                      )
                  );
                }
              } else {
                return Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Lottie.asset('assets/lottie_loading1.json'),
                  ),
                );
              }
            },
          ),
        ));
  }
}
