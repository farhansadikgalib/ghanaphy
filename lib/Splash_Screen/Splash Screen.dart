import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghanaphy/Check_Connection/No%20Internet.dart';
import 'package:ghanaphy/Check_Connection/check_internet.dart';
import 'package:ghanaphy/Page_Controller/Pages_With_Bottom_Navbar.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {


  int checkInt = 0;

  @override
  void initState() {
    super.initState();
    Future<int> a = CheckInternet().checkInternetConnection();
    a.then((value) {
      if (value == 0) {
        setState(() {
          checkInt = 0;
        });
        print('No internet connect');
        Timer(
            Duration(seconds: 4),
                () =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => No_Internet_Connection()),
                        (route) => false));
      } else {
        setState(() {
          checkInt = 1;
        });
        print('Internet connected');
        Timer(
            Duration(seconds: 4),
                () =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    //     HomePage(
                    //     url: 'https://ghanaphy.com/wp-login.php'
                    // )
                      Nav_bar()
                    ),
                        (route) => false));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Connected to the internet'),
        ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(243, 215, 171, 1),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                height: 150,
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    "assets/s_logo.png",
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),


          Text("EXPERT WITH VISION",
              style: TextStyle(fontSize: 20, fontFamily: "Poppins",color: Colors.green[800])),

          SizedBox(
            height: 50,
          ),

          SpinKitFadingCube(
            color: Colors.orangeAccent,
            size: 25.0,
            controller: AnimationController(
                duration: const Duration(milliseconds: 1300), vsync: this),
          ),

          SizedBox(
            height: 50,
          ),
          // _AnimatedLiquidLinearProgressIndicator(),
        ],
      ),
      ),
    );
  }
}


///https://ghanaphy.com/my-account/private-messages/
///https://ghanaphy.com/my-account/all-notifications/
///https://ghanaphy.com/my-account/shopping/