import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sentiment_analysis/main.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  width: 200,
                  child: Lottie.asset('assets/emotion.json'),
                ),
                SizedBox(height: 50,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Shimmer.fromColors(
                          baseColor: Colors.yellow[300],
                          highlightColor: Colors.orangeAccent,
                          child: Text('Sentiment',style: TextStyle(fontWeight: FontWeight.w700,fontSize:30,),)),
                      SizedBox(height: 5,),
                      Shimmer.fromColors(
                          baseColor: Colors.yellow[300],
                          highlightColor: Colors.orangeAccent,
                          child: Text('Analysis',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),)),


                    ],
                  ) ,
                )
              ],
            ),
          ),
        )
    );
  }
}
