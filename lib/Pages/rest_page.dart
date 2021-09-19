
import 'dart:convert';
import 'dart:io';


import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapptotpglobal/PojoClass/rest_response.dart';
import 'package:http/http.dart';



class MyRestApp extends StatefulWidget {
  @override
  _MyRestAppState createState() => _MyRestAppState();
}

class _MyRestAppState extends State<MyRestApp> {

  List<Results> _restList = [];
  List<Results> _searchList = [];
  var responseJsonRest = null;
  var responseJsonSearch = null;
  var ShowMainList = true;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    try
    {
      _GetRestaurantListMain(context);
    }
    catch(e)
    {
      print(e);
    }

  }

  Future<dynamic> _GetRestaurantListMain(BuildContext context) async {
    // make GET request
//    _ShowProgressBar();

    _showDialogInit();
//    showDialog(
//        barrierDismissible: false, // JUST MENTION THIS LINE
//        context: context,
//        builder: (BuildContext context) {
//          return WillPopScope(
//              onWillPop: () {},
//              child: Center(
//                  child: CircularProgressIndicator(
//                      backgroundColor: Colors.white,
//                      semanticsLabel: 'Processing, please wait.',
//                      strokeWidth: 5)));
//        });

    try {

      String url ='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&key=AIzaSyDxVclNSQGB5WHAYQiHK-VxYKJelZ_9mjk';

      debugPrint('_GetRestaurantListMain url : ' + url);

      Response response = await get(Uri.parse(url),headers: {"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"});
      // sample info available in response
      int statusCode = response.statusCode;
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];
      // String json = response.body;

      if (_restList == null) {
        _restList = [];
      } else {
        _restList.clear();
      }

      // debugPrint('_GetTransactionMinistatement data JSON : $json');

      if (response.body == null) {
        _DismissProgressBar(context);

        throw new Exception("Error while fetching data");
      } else {
        _DismissProgressBar(context);
        responseJsonRest = json.decode(response.body);

        debugPrint('_GetRestaurantListMain data : $responseJsonRest');

        String status = "";

       // status = responseJsonRest['status'];

        debugPrint('_GetRestaurantListMain status aaa : $status');

        //if (status == "SUCCESS")
        {
          RestaurantResponsePojo responsebody =
          new RestaurantResponsePojo.fromJson(responseJsonRest);

          if ((responsebody.results == null) ||
              (responsebody.results.length <= 0)) {
            debugPrint('_GetRestaurantListMain _bank size is 0 or null');


          } else {


            _restList = responsebody.results;
            String length = _restList.length.toString();

            debugPrint(
                '_GetRestaurantListMain list size ' +
                    length);
          }

//          setState(() {
//
//          });

        }
//        else {
//
//
////          setState(() {
////
////          });
//        }
      }

    } catch (e) {

      _DismissProgressBar(context);

//      setState(() {
//
//      });
      print(e);

    }

    setState(() {

    });

    return _restList;

    // TODO convert json to object...
  }

  Future<dynamic> _GetRestaurantListKeyword(String Keyword,BuildContext context) async {
    // make GET request
    _ShowProgressBar();



    try {

      String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&keyword=:$Keyword&key=AIzaSyDxVclNSQGB5WHAYQiHK-VxYKJelZ_9mjk';
      debugPrint('_GetRestaurantListMain url : ' + url);
      Response response = await get(Uri.parse(url));
      // sample info available in response
      int statusCode = response.statusCode;
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];
      // String json = response.body;

      if (_searchList == null) {
        _searchList = [];
      } else {
        _searchList.clear();
      }

      // debugPrint('_GetTransactionMinistatement data JSON : $json');

      if (response.body == null) {
        _DismissProgressBar(context);

        throw new Exception("Error while fetching data");
      } else {
        _DismissProgressBar(context);
        responseJsonSearch = json.decode(response.body);

        debugPrint('_GetRestaurantListMain data : $responseJsonSearch');

        String status = "";

        //status = responseJsonRest['status'];

       // debugPrint('_GetRestaurantListMain status aaa : $status');

       // if (status == "SUCCESS")
        {
          RestaurantResponsePojo responsebody =
          new RestaurantResponsePojo.fromJson(responseJsonSearch);

          if ((responsebody.results == null) ||
              (responsebody.results.length <= 0)) {
            debugPrint('_GetRestaurantListMain _bank size is 0 or null');


          } else {


            _searchList = responsebody.results;
            String length = _searchList.length.toString();

            debugPrint(
                '_GetRestaurantListMain list size ' +
                    length);
          }

//          setState(() {
//
//          });

        }

      }

    } catch (e) {

      _DismissProgressBar(context);

//      setState(() {
//
//      });
      print(e);

    }

    setState(() {

    });

    return _searchList;

    // TODO convert json to object...
  }

  onSearchTextChanged(String text) async {
    _searchList.clear();
    if (text.isEmpty) {
      setState(() {
        ShowMainList = true;
      });
      return;
    }

    ShowMainList = false;

  _GetRestaurantListKeyword(text,context);

    setState(() {

    });
  }


  _showDialogInit() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              child: Center(
                child:  CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  semanticsLabel: 'Processing, please wait.',
                  strokeWidth: 5),
              ),
              );
        });
  }

  _ShowProgressBar() {
    try {


      showDialog(
          barrierDismissible: false, // JUST MENTION THIS LINE
          context: context,
          builder: (BuildContext context) {
            return const Center(
                child: const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    semanticsLabel: 'Processing, please wait.',
                    strokeWidth: 5));
          });
    } catch (e) {
      print(e);
    }
  }

  _DismissProgressBar(BuildContext context) {
    try {

      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant App'),
        ),
        body: new Column(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),
            new Expanded(
              child: _searchList.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                itemCount: _searchList.length,
                itemBuilder: (context, i) {
                  return new Card(
                    child: new ListTile(
                      leading: new CircleAvatar(backgroundImage: new NetworkImage(_searchList[i].icon,),backgroundColor: Colors.transparent,),
                      title: Column(
                        children: [
                          Text(_searchList[i].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color:  Colors.black,
                          )),
                          Text("Ratings : "+ _searchList[i].rating.toString())
                        ],
                      )
                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              )
                  : new ListView.builder(
                itemCount: _restList.length,
                itemBuilder: (context, index) {
                  return new Card(
                    child: new ListTile(
                      leading: new CircleAvatar(backgroundImage: new NetworkImage(_restList[index].icon,),backgroundColor: Colors.transparent,),
                      title: Column(
                        children: [
                          Text(_restList[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color:  Colors.black,
                              )),
                          Text("Ratings : "+_restList[index].rating.toString())],
                      ),


                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}