import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ghanaphy/Check_Connection/No%20Internet.dart';
import 'package:ghanaphy/Home_Page/HomePage.dart';
import 'package:ghanaphy/Home_Page/HomePage2.dart';
import 'package:ghanaphy/Home_Page/HomePage3.dart';
import 'package:ghanaphy/Splash_Screen/Splash%20Screen.dart';
import 'package:shimmer/shimmer.dart';

// final String url;

class Nav_bar extends StatefulWidget {
  // Nav_bar({Key? key, required this.url}) : super(key: key);

  @override
  _Nav_barState createState() => _Nav_barState();
}

class _Nav_barState extends State<Nav_bar> {

  int checkInt = 0;
  late ConnectivityResult previous;
  InAppWebViewController? _webViewController;

  double progress = 0;
  String url = '';

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        javaScriptEnabled: true,
        useShouldOverrideUrlLoading: true,
        useOnDownloadStart: true,
      ),
      android: AndroidInAppWebViewOptions(
        initialScale: 100,
        useShouldInterceptRequest: true,
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();




  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(url: 'https://ghanaphy.com/wp-login.php/'),
    HomePageX(url: 'https://ghanaphy.com/my-account/private-messages/'),
    HomePageXX(url: 'https://ghanaphy.com/my-account/all-notifications/'),
    HomePageX(url: 'https://ghanaphy.com/user'),

 ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;


      print('${index}');
    });
  }




  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.yellow[800]),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController?.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
              urlRequest: URLRequest(url: await _webViewController?.getUrl()));
        }
      },
    );


    Connectivity().onConnectivityChanged.listen((
        ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => No_Internet_Connection()), (
            route) => false);
      } else if (previous == ConnectivityResult.none) {
        // internet conn
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => No_Internet_Connection()), (
            route) => false);
      }

      previous = connresult;
    });
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'No',
              style: TextStyle(color: Colors.green[800]),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text(
              'Yes',
              style: TextStyle(color: Colors.red[800]),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(243, 215, 171, 1),
          title: Shimmer.fromColors(
            baseColor: Colors.lightGreen,
            highlightColor: Color.fromRGBO(255, 146, 72, 1),
            child: Column(
              children: [
                Text(
                  'Ghanaphy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _webViewController?.goBack();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                _webViewController?.reload();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,

              ),

            ),
            IconButton(
              onPressed: () {
                _webViewController?.goForward();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),

            SizedBox(width: 10),
          ],
        ),

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          // currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          backgroundColor: Color.fromRGBO(243, 215, 171, 1),
          dotIndicatorColor: Color.fromRGBO(243, 215, 171, 1),
          unselectedItemColor: Colors.grey,
          enableFloatingNavBar: false,
          // onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.white,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.message),
              selectedColor: Colors.white,
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.notifications),
              selectedColor: Colors.white,
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Colors.white,
            ),
          ],
        ),



      ),
    );
  }
}
