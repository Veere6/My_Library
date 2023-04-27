
import 'package:flutter/material.dart';
import 'package:my_library/BookDetails.dart';
import 'package:my_library/Services/Intitlemodel/Intitlemodel.dart';
import 'package:my_library/Services/Services.dart';

class SearchBooks extends StatefulWidget{
  @override

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SearchBooks> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _currentTabIndex = 0;
  late Intitlemodel intitlemodel;
  final TextEditingController _searchController = TextEditingController();
  String category = "intitle";
  @override
  void initState(){
    _tabController = new TabController(length: 4, vsync: this);
    _searchController.addListener((){
      GetBook("${_searchController.text}");
      setState(() {
      });
    });
    // GetBook("java");
    super.initState();
  }

  @override
  void dispose() {

    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void GetBook(String quary)async{
    itemBook.clear();
    intitlemodel = await Services.GetBooks(category,"$quary");
    for(Item item in intitlemodel.items ?? []){
      itemBook.add(item);
    }
    setState(() {
    });
  }

  List<Item> itemBook = [];

  bool islist=false;

  @override
  Widget build(BuildContext context) {
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

                    new SizedBox(width: 50,),
                    Spacer(),
                    Text('Search Online',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Spacer(),
                    new InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',style: TextStyle(color: Colors.white),),
                    ),
                    new SizedBox(width: 20,),
                  ],
                ),
              ),
            ),
            Container(height: 0.5,color: Colors.white54,),
            SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xff1b364b),
                borderRadius: BorderRadius.circular(10)
              ),
              // Add padding around the search bar
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // Use a Material design search bar
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  // Add a clear button to the search bar
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey,),
                    onPressed: () => _searchController.clear(),
                  ),
                  // Add a search icon or button to the search bar
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.grey,),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),
                  border: InputBorder.none
                ),
              ),
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  new Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _currentTabIndex=0;
                            category = "intitle";
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
                          setState(() {
                            _currentTabIndex=1;
                            category = "inauthor";
                          });
                        },
                        child: Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                          decoration: BoxDecoration(
                            color: _currentTabIndex==1 ? Colors.white:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text("Author",style: TextStyle(color: Colors.black),),
                        ),
                      )
                  ),
                  new Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _currentTabIndex=2;

                            category = "inpublisher";
                          });
                        },
                        child: Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                          decoration: BoxDecoration(
                            color: _currentTabIndex==2 ? Colors.white:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text("Publisher",style: TextStyle(color: Colors.black),),
                        ),
                      )
                  ),
                  new Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _currentTabIndex=3;

                            category = "ISBN_10";
                          });
                        },
                        child: Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                          decoration: BoxDecoration(
                            color: _currentTabIndex==3 ? Colors.white:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text("ISBN",style: TextStyle(color: Colors.black),),
                        ),
                      )
                  ),
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).padding.top+100,
                // width: double.infinity,
                  color: Colors.white,
                  child: itemBook.isNotEmpty ?
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
                            MaterialPageRoute(builder: (context) =>  BookDetails(value,category)),
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
                                                      child: Text("${value.volumeInfo?.title ?? ""}",maxLines: 2,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
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
                            child: Text('Add books with the + icon to\nyour book list',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,)),
                      ],
                    ),
                  )

              ),
            ),

          ],
        ),
      ),
    );
  }
}