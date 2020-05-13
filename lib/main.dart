import 'package:flutter/material.dart';
import 'package:sentiment_analysis/Result/resutl.dart';
import 'package:lottie/lottie.dart';
import 'model/model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sentiment_analysis/model/theme.dart';
import 'SplashScreen/splash_screen.dart';
//import 'package:load_toast/load_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var mainTheme;

  @override
  Widget build(BuildContext context) {
//    print(FlutterConfig.get('API_URL'));
    return ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
              return MaterialApp(
                title: "Lottie",
                theme: notifier.darkTheme ? darktheme : lighttheme,
                home: SplashScreen(),
                debugShowCheckedModeBanner: false,
              );
            }));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var text = "";
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var theme_val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child)
            {
              print("This is ${notifier.darkTheme}");
             return (notifier.darkTheme) ? IconButton(
                icon: Icon(Icons.wb_sunny,color: Colors.yellow,), onPressed: () {
                notifier.toogleTheme();
              },):IconButton(icon: Icon(Icons.wb_sunny,color: Colors.black54,),onPressed: (){
                notifier.toogleTheme();
              },);
            },
          )
        ],
        title: Center(child: Text("Sentiment Analysis",style: TextStyle(fontWeight:FontWeight.w300
        ),)),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Get Sentiment"),
          icon: Container(
            height: 20,
            child: Lottie.asset('assets/emotion.json'),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          onPressed: () async {
            print(text);
            print(text.length);
            if (text.length <= 0) {
              print("okok");
              Fluttertoast.showToast(
                  textColor: Colors.white,
                  backgroundColor: Colors.teal,
                  msg: "Write Something Meaningfull 🤓",
                  toastLength: Toast.LENGTH_SHORT);
            } else {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Result(text)));
            }
//                  postData("Good Good Good Good Good");
          }),
      body: Container(
          margin: EdgeInsets.all(5),
          child: Form(
            key: _key,
            child: TextFormField(
              maxLines: 1000,
              style: TextStyle(fontSize: 30),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Enter Text"),
              onChanged: (val) {
                text = val;
              },
            ),
          )),
    );
  }

  void onThemeChanged(var val, var themeChanger) async {
    val == 0
        ? themeChanger.setTheme(darktheme)
        : themeChanger.setTheme(lighttheme);
//    var pref= await SharedPreferences.getInstance();
//    pref.setInt('darkmode',val);
  }

  static getThemevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int theme_val = prefs.getInt('darkmode') ?? 0;
    return theme_val;
  }
}
