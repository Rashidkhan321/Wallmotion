


import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallmotion/components/imagecomponet.dart';
import '../Data/Networ/Api_Services/Apiservices.dart';
import '../components/categorylist.dart';
import '../components/themchnage.dart';
import 'SerachScreen.dart';
import 'imageFullScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final serachcontroller = TextEditingController();
   final obj = photodata();
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(

            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ?? false;
      },
      child: Scaffold(


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
          actions: [
            // Switch for toggling the theme
            Switch(
              value: Provider.of<ThemeProvider>(context).themeData.brightness == Brightness.dark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
            ),
          ],
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

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SerachScreen(query: serachcontroller.text,))).then((value) => {
                              serachcontroller.clear()
                            });
                            print(serachcontroller.text.toString());

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
                           ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Fill the filed'),
                           duration: Duration(seconds: 2),
                           ));


                         }
                         else{

                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SerachScreen(query: serachcontroller.text,))).then((value) => {
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
            Categorylist(),
            Expanded(
              child:


           Consumer<photodata>(builder: (index, value, child){
             return    FutureBuilder(

               future: value.getdata(),
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
                           child: InkWell(
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
      ),
    );
  }
}
