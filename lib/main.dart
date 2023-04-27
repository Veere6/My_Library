import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_library/BookDetails.dart';
import 'package:my_library/Services/DataBase.dart';
import 'package:my_library/Services/Intitlemodel/Intitlemodel.dart';
import 'package:my_library/Services/SearchBooks.dart';
import 'package:my_library/Services/Services.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // scaffoldBackgroundColor: Color(0xff224b71)
          primaryColor: Color(0xff224b71),
          accentColor: Color(0xff224b71),
          // accentColorBrightness: Color(0xff224b71)
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

}

class SplashScreen extends StatefulWidget{
  @override

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _currentTabIndex = 0;

  StreamController<Intitlemodel> streamController = StreamController();
  late Stream<Intitlemodel> userStream;
  late Intitlemodel intitlemodel;
  late DataBase handler;
  @override
  void initState(){
    handler = DataBase();
    _tabController = new TabController(length: 2, vsync: this);
    GetBook();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void GetBook()async{
    // itemBook.clear();
    if(_currentTabIndex==0) {
      itemBook = await handler.retrievePlanets();
    }else{
      itemBook2 = await handler.retrievePlanets2();
    }
     setState(() {
    });
  }

  List<Item> itemBook = [];
  List<Item> itemBook2 = [];

  bool islist=false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Color(0xff224b71),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 10,),
            SizedBox(
             height: 50,
             child: Container(
               child: Row(
                 children: [
                   IconButton(
                     icon: Icon(islist ? Icons.grid_view :Icons.list,color: Colors.white,),
                     tooltip: 'List',
                     onPressed: () {
                       setState(() {
                         if(islist){
                           islist=false;
                         }else{
                           islist=true;
                         }
                       });
                     },
                   ),
                   Spacer(),
                   Text('My Library',style: TextStyle(color: Colors.white),),
                   Spacer(),
                   IconButton(
                     icon: const Icon(Icons.add,color: Colors.white,),
                     tooltip: 'Add Books',
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) =>  SearchBooks()),
                       ).then((value) => GetBook());
                     },
                   ),
                 ],
               ),
             ),
            ),
            Container(height: 0.5,color: Colors.white54,),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  new Expanded(
                      child: InkWell(
                        onTap: (){
                          GetBook();
                          _tabController.animateTo((_tabController.index - 1) % 2);
                          setState(() {
                            _currentTabIndex=0;
                          });
                        },
                        child: Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                          decoration: BoxDecoration(
                            color: _currentTabIndex==0 ? Colors.white:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text("Title",style: TextStyle(color: Colors.black),),
                        ),
                      )
                  ),
                  new Expanded(
                      child: InkWell(
                        onTap: (){
                          GetBook();
                          _tabController.animateTo((_tabController.index + 1) % 2);
                          setState(() {
                            _currentTabIndex=1;
                          });
                        },
                        child: Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                          decoration: BoxDecoration(
                            color: _currentTabIndex==0 ? Colors.transparent:Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text("Author",style: TextStyle(color: Colors.black),),
                        ),
                      )
                  ),
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Container(
                    // height: MediaQuery.of(context).padding.top+100,
                    // width: double.infinity,
                    color: Colors.white,
                    child: itemBook.isNotEmpty ?
                    islist ? new GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                          controller: new ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          scrollDirection: Axis.vertical,
                          children: itemBook.map((Item value) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  BookDetails(value,"intitle")),
                                );
                              },
                              child: new Container(
                                color: Colors.white,
                                margin: new EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    new Expanded(
                                        child: Container(
                                          child: Image.network("${value.volumeInfo?.imageLinks?.thumbnail}"),
                                        )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: new Container(
                                            child: Text("${value.volumeInfo?.title}",maxLines: 1,style: TextStyle(fontSize: 18,color: Colors.black87),textAlign: TextAlign.center,),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )
                            :
                        ListView.builder(
                          itemCount: itemBook.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            late Item value;
                            if(itemBook.isNotEmpty) {
                              value = itemBook[index];
                            }
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  BookDetails(value,"intitle")),
                                );
                              },
                              child: new Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                margin: new EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10,),
                                        SizedBox(
                                          height:100,
                                          width: 100,
                                          child: Image.network("${value.volumeInfo?.imageLinks?.thumbnail ?? ""}"),
                                        ),
                                        SizedBox(width: 10,),
                                        new Expanded(
                                            child: Container(
                                               child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: new Container(
                                                            child: Text("${value.volumeInfo?.title ?? ""}",maxLines: 1,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: new Container(
                                                            child: Text("${/*value.volumeInfo?.authors?.isEmpty==true ? "":*/value.volumeInfo?.authors?.join(",") ?? ""}",maxLines: 1,style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: new Container(
                                                            child: Text("${value.volumeInfo?.publisher ?? ""}",maxLines: 1,style: TextStyle(fontSize: 12,color: Colors.black38,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            )
                                        ),

                                      ],
                                    ),
                                    Spacer(),
                                    Container(height: 0.5,color: Colors.black87,)
                                  ],
                                ),
                              ),
                            );
                          },
                        ):
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text('Add books with the + icon to\nyour book list',style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.center,)),
                            ],
                          ),
                        )

                  ),

                  // second tab bar viiew widget
                  Container(
                    // height: MediaQuery.of(context).padding.top+100,
                    // width: double.infinity,
                      color: Colors.white,
                      child: itemBook2.isNotEmpty ?
                      islist ? new GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        controller: new ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        scrollDirection: Axis.vertical,
                        children: itemBook2.map((Item value) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  BookDetails(value,"intitle")),
                              );
                            },
                            child: new Container(
                              color: Colors.white,
                              margin: new EdgeInsets.all(1.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Expanded(
                                      child: Container(
                                        child: Image.network("${value.volumeInfo?.imageLinks?.thumbnail}"),
                                      )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: new Container(
                                          child: Text("${value.volumeInfo?.title}",maxLines: 1,style: TextStyle(fontSize: 18,color: Colors.black87),textAlign: TextAlign.center,),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                          :
                      ListView.builder(
                        itemCount: itemBook2.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          late Item value;
                          if(itemBook2.isNotEmpty) {
                            value = itemBook2[index];
                          }
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  BookDetails(value,"intitle")),
                              );
                            },
                            child: new Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              margin: new EdgeInsets.all(1.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10,),
                                      SizedBox(
                                        height:100,
                                        width: 100,
                                        child: Image.network("${value.volumeInfo?.imageLinks?.thumbnail ?? ""}"),
                                      ),
                                      SizedBox(width: 10,),
                                      new Expanded(
                                          child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: new Container(
                                                          child: Text("${value.volumeInfo?.title ?? ""}",maxLines: 1,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: new Container(
                                                          child: Text("${/*value.volumeInfo?.authors?.isEmpty==true ? "":*/value.volumeInfo?.authors?.join(",") ?? ""}",maxLines: 1,style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: new Container(
                                                          child: Text("${value.volumeInfo?.publisher ?? ""}",maxLines: 1,style: TextStyle(fontSize: 12,color: Colors.black38,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                          )
                                      ),

                                    ],
                                  ),
                                  Spacer(),
                                  Container(height: 0.5,color: Colors.black87,)
                                ],
                              ),
                            ),
                          );
                        },
                      ):
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text('Add books with the + icon to\nyour book list',style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.center,)),
                          ],
                        ),
                      )

                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

