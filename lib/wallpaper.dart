
import 'package:flutter/material.dart';

class Wallpapar extends StatefulWidget {
  const Wallpapar({super.key});

  @override
  State<Wallpapar> createState() => _WallpaparState();
}

class _WallpaparState extends State<Wallpapar> {
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
                      return Container(
                        color: Colors.white,
                      );
                    },
               ),

              )),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.black54,
            child: Text(
              'Load More',style: TextStyle(
              fontSize: 20,
              color:Colors.red
            ),
            ),
          )
        ],
      ),
    );
  }
}
