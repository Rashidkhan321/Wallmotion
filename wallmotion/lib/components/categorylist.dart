

import 'package:flutter/material.dart';

import '../View/CategoryScreen.dart';


class Categorylist extends StatelessWidget {
  const Categorylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> catlist = ['Places','Animals', 'Fashion','Car', 'Nature','Flower','Travel','Snakes', 'Buildings',  'Music','Science', 'Education', 'Feelings',
      'Health', 'People', 'Religion', 'Backgrounds',
        'Industry', 'Computer', 'Food', 'Sports', 'Transportation', 'Business'];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: catlist.length,
          itemBuilder: (context, index){
        return Row(
          children: [
            SizedBox(width: 10,),
            InkWell(
              onTap: (){


            Navigator.push(context, MaterialPageRoute(builder:
            (context)=>CategoryScreen(category: catlist[index].toString())));
            },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 40,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(catlist[index].toString(),style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
