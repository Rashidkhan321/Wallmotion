import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../Data/Networ/Api_Services/Apiservices.dart';
import '../components/imagecomponet.dart';
import 'imageFullScreen.dart';

class SerachScreen extends StatefulWidget {
  final query;
  const SerachScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SerachScreen> createState() => _SerachScreenState();
}

class _SerachScreenState extends State<SerachScreen> {
  @override
  Widget build(BuildContext context) {
    final serachcontroller = TextEditingController();
    final obj = photodata();
    return Scaffold(

      appBar:

      AppBar(automaticallyImplyLeading: false,
        title: Center(child:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(

              radius: 20, // Adjust the radius as needed
              backgroundImage: AssetImage('images/sign.png'),

            ),

            SizedBox(width: 50,),

          ],
        ) ),
      ),

      body:

      Column(
        children: [


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (String ){
                          if(serachcontroller.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Center(child: Text('Fill the filed')),
                              backgroundColor: Colors.grey,
                              duration: Duration(seconds: 2),
                            ));

                          }
                          else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                (context)=>SerachScreen(query: serachcontroller.text,))).then((value) => {
                              serachcontroller.clear()
                            });
                          }



                        },

                        controller: serachcontroller,
                        decoration: InputDecoration(
                          hintText: 'serach...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,

                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          if(serachcontroller.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Center(child: Text('Fill the filed')),
                              backgroundColor: Colors.grey,
                              duration: Duration(seconds: 2),
                            ));



                          }
                          else{

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SerachScreen(query: serachcontroller.text,))).then((value) => {
                              serachcontroller.clear()
                            });
                            print(serachcontroller.text.toString());

                          }

                        },
                        child: Icon(Icons.search_rounded))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(


            child:
            Consumer<photodata>(builder: (index, value, child){
              return     FutureBuilder(

                future: value.serachdata(widget.query.toString()),
                builder: ( context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasError){
                    return Text((snapshot.hasError.toString()));
                  }
                  else if(snapshot.requireData.hits!.isEmpty){
                    return Center(child: Text(('NO DATA')));
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
                            child:InkWell(
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


              );
    })

          )
        ],
      ),
    );
  }
}
