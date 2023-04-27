
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:my_library/Services/DataBase.dart';
import 'package:my_library/Services/Intitlemodel/Intitlemodel.dart';

class BookDetails extends StatefulWidget{
  BookDetails(this.value,this.from);
  Item value;
  String from;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<BookDetails>{
  late DataBase handler;
  @override
  void initState(){
    handler = DataBase();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  List<Item> itemBook = [];
  void saveBook(Item item)async{
    itemBook.add(item);
    final jsonString = json.encode(itemBook);
    if(widget.from=="inauthor"){
      await handler.insertPlanets2(jsonString);
    }else{
      await handler.insertPlanets(jsonString);
    }
    // print("Add Successfully");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          message: 'Book added successfully!',
        );
      },
    );
  }

  Future<void> _launchURLBrowser(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget getWidget(String title,String discrition){
   return Container(
     padding: const EdgeInsets.symmetric(horizontal: 20),
     child: Column(
       children: [
         new Container(
           margin: const EdgeInsets.only(bottom: 10,top: 10),
           height: 0.5,color: Colors.black87,),
         new Row(
           children: [
             new Expanded(child: Text("${title}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))
           ],
         ),
        if(discrition.isNotEmpty) new Row(
           children: [
             new Expanded(child: Text("${discrition}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),))
           ],
         ),
         // new Container(
         //   margin: const EdgeInsets.only(top: 10),
         //   height: 0.5,color: Colors.black87,),
       ],
     ),
   );
  }

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
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                      tooltip: 'Add Books',
                      onPressed: () {
                       Navigator.pop(context);
                      },
                    ),
                    Text('Back',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text('Book Details',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Spacer(),
                    new InkWell(
                      onTap: (){
                        saveBook(widget.value);
                      },
                      child: Text('Save',style: TextStyle(color: Colors.white),),
                    ),
                    new SizedBox(width: 20,),
                  ],
                ),
              ),
            ),
            Container(height: 0.5,color: Colors.white54,),
            new Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          child: SizedBox(
                            height:200,
                            width: 200,
                            child: Image.network("${widget.value.volumeInfo?.imageLinks?.thumbnail ?? ""}"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child:Text("${widget.value.volumeInfo?.title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                        ),
                        getWidget("Authors","${widget.value.volumeInfo?.authors?.join(",") ?? ""}"),
                        getWidget("Publisher","${widget.value.volumeInfo?.publisher ?? ""}"),
                        getWidget("Publication Date","${widget.value.volumeInfo?.publisher ?? ""}"),
                        getWidget("Pages","${widget.value.volumeInfo?.pageCount ?? ""}"),
                        getWidget("Categories","${widget.value.volumeInfo?.categories?.join(",") ?? ""}"),
                        getWidget("ISBN",""),
                        getWidget("Description","${widget.value.volumeInfo?.description ?? ""}"),
                        new Container(
                          margin: const EdgeInsets.only(bottom: 10,top: 10,left: 20,right: 20),
                          height: 0.5,color: Colors.black87,),
                        InkWell(
                          onTap: (){
                            _launchURLBrowser("${widget.value.volumeInfo?.previewLink ?? ""}");
                          },
                          child: Container(
                            child:Text("Preview On Google Books",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Color(0xff224b71))),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(bottom: 10,top: 10,left: 20,right: 20),
                          height: 0.5,color: Colors.black87,),
                      ],
                    ),
                  ),
                )
            ),




          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String message;

  CustomDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 150.0,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            Text(
              message,
              style: TextStyle(fontSize: 16.0,color: Colors.black87,),
            ),
            Spacer(),
            Divider(height: 1,color: Colors.black87,),
            SizedBox(height: 16,),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 16.0,color: Colors.cyan),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

