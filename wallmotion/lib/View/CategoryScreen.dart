
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Data/Networ/Api_Services/Apiservices.dart';
import '../components/imagecomponet.dart';
import 'imageFullScreen.dart';

class CategoryScreen extends StatefulWidget {
  final category;
  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final serachcontroller = TextEditingController();
  final obj = photodata();
  List<String> animallist = ['Places','Animals', 'Fashion', 'Nature','Car','Naked Woman','Travel', 'Buildings',  'Music','Science', 'Education', 'Feelings',
    'Health', 'People', 'Religion', 'Backgrounds',
    'Industry', 'Computer', 'Food', 'Sports', 'Transportation', 'Business'];
  List<String> caritems =[
    'BMW',
    'Toyota',
    'Hyundai',
    'SAIC',
    'Ferrari',
    'Honda',
    'Tesla'
  ];
  List<String>floweritems=[
    'Rose',
    'waterlily',
    'Sunflower',
    'Petunia',
    'Winter Viola',
    'Peony',
    'Lilac bush'

  ];
  List<String> animalitems=[
    'Tiger',
    'Lion',
    'Cat',
    'Wolf',
    'Buterfly',
    'Rabbit',
    'Fox',
    'Dolphin',


  ];
  List<String> cityitem=[
    'Sydney',
    'Barcelona',
    'Queenstown',
    'Istanbul',
    'Paris',
    'Cape Town',
    'Seoul',
    'Kyoto',
    'Tbilisi'
  ];
  List<String> courtyitem =[
    'Maldives',
    'Costa Rica',
    'United States',
    'Peru',
    'Japan',
    'Iceland',
    'Kenya',
    'Namibia',
    'Greece',
  ];
  List<String> natureitem =[
    'Spring',
    'Grass',
    'Summer',
    'River',
    'Graden',
    'Tree',
    'Water',
    'Mountain',
    'Iceland',
    'Landscape',


  ];
  List<String> Backgrounds =[
    'nature','wallpaper','floral backgrounds','mac wallpaper','wallpaper 4k'];



  @override
  Widget build(BuildContext context) {
    List<String> catlist=[];
    if(widget.category=='Animals'){
      catlist=animalitems;

    }
    else if(widget.category=='Places'){
      catlist=courtyitem;

    }
    else if(widget.category=='Car'){
      catlist=caritems;
    }
    else if(widget.category=='Nature'){
      catlist=natureitem;
    }
    else if(widget.category=='Backgrounds'){
      catlist=Backgrounds;
    }
    else if(widget.category=='Flower'){
      catlist=floweritems;
    }

    return Scaffold(


      body:

      Column(
        children: [


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 200,
              child: FutureBuilder(

                future: obj.serachdata(widget.category),
                builder: ( context, snapshot) {
                  if(!snapshot.hasData){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(

                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,

                        ),

                      ),
                    );
                  }
                  else if(snapshot.hasError){
                    return Text((snapshot.hasError.toString()));
                  }


                  else{
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return   ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(

                            height: 250,
                            decoration: BoxDecoration(

                            ),
                            child: Stack(
                              children: [
                                imagepick(imageurl:
                                snapshot.data!.hits![index].largeImageURL.toString(), imagpet: BoxFit.fill,),
                                Container(
                                  height: 250,
                                  decoration: BoxDecoration(
color: Colors.white12.withOpacity(0.4),

                                  ),
                                ),
                             Align(
                               alignment: Alignment.bottomCenter,
                               child: SizedBox(
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
                                                       ),
                             )
                              ],
                            ),
                          ),
                        );
                      },



                    );

                  }
                },


              ),
            ),
          ),

        //  Categorylist(),
          Expanded(
            child: FutureBuilder(

              future: obj.serachdata(widget.category),
              builder: ( context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text((snapshot.hasError.toString()));
                }


                else{
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MasonryGridView.builder(
                      itemCount: snapshot.data!.hits!.length,

                      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),
                      itemBuilder: (context, index) {
                        List<double> itemhight =[ 250, 300, 400];
                        double height = itemhight[index% itemhight.length];

                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child:
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  ImageFullScreen(imageurl: snapshot.data!.hits![index].largeImageURL.toString(),)));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(

                                height: height,
                                decoration: BoxDecoration(

                                ),
                                child: imagepick(imageurl:
                                snapshot.data!.hits![index].largeImageURL.toString(), imagpet: BoxFit.fill,),
                              ),
                            ),
                          ),
                        );
                      },),
                  );
                }
              },


            ),
          )
        ],
      ),
    );
  }
}
