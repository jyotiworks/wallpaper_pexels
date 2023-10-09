
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_pexels_app/fullscreen.dart';

class Wallpapar extends StatefulWidget {
  const Wallpapar({super.key});

  @override
  State<Wallpapar> createState() => _WallpaparState();
}

class _WallpaparState extends State<Wallpapar> {


  // List Images

  List images = [];
  int page = 1;

  //Fetch Api Function

  fetchApi() async{
 await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
   headers:
     {
       'Authorization' : 'ozIm60oMa6std9bx7Nk1OQYFYD6IDoq1DhX7wKqNDVj52K0IplbD5ZV8'
     }
 ).then((value) {

   Map result = jsonDecode(value.body);
   setState(() {
     images = result['photos'];
   });
   print(images[0]);
 });
  }

  // Load More Function

  /*loadMore() async{
    setState(() {
      page = page+ 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page' + page.toString();
    await http.get(Uri.parse(url),
        headers:
        {
          'Authorization' : 'ozIm60oMa6std9bx7Nk1OQYFYD6IDoq1DhX7wKqNDVj52K0IplbD5ZV8'
        }
    ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
      print(images[0]);
    });

  }*/

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {'Authorization': 'ozIm60oMa6std9bx7Nk1OQYFYD6IDoq1DhX7wKqNDVj52K0IplbD5ZV8'}).then(
            (value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images.addAll(result['photos']);
          });
        });
  }



  @override
  void initState() {
    // TODO: implement initState

    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child:  Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2/3,
                      mainAxisSpacing: 2
                    ),
                  itemCount: 80,
                    itemBuilder:(context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imageurl:images[index]['src']['large2x'] )));
                        },

                        child: Container(
                          color: Colors.white,
                          child: Image.network(images[index]['src']['tiny'],
                          fit: BoxFit.cover,),
                        ),
                      );
                    },
               ),

              )),
          InkWell(
            onTap: (){
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black54,
              child: Center(
                child: Text(
                  'Load More',style: TextStyle(
                  fontSize: 20,
                  color:Colors.white
                ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
