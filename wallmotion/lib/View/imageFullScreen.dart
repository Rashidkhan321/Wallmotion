import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageFullScreen extends StatefulWidget {
  final imageurl;
  const ImageFullScreen({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
//use all these functions
  bool loading = false;
  void saveimage() async{
    setState(() {
      loading=true;
    });
    await GallerySaver.saveImage(widget.imageurl).then((value) {
    setState(() {
      loading=false;
    });


showDialog(context: context, builder: (context){
  return AlertDialog(
    content: Container(
      height: 200,
      width: 200,
      child: Column(
        children: [
          ListTile(
            onTap: ()async{
              Navigator.pop(context);
              int Location = WallpaperManager.HOME_SCREEN;
              var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
              await WallpaperManager.setWallpaperFromFile(file.path ,Location );

            },
            title: Text('Set as HOME_SCREEN'),
          ),
          ListTile(
            onTap: ()async{
              Navigator.pop(context);
              int Location = WallpaperManager.LOCK_SCREEN;
              var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
              await WallpaperManager.setWallpaperFromFile(file.path ,Location );

            },
            title: Text('Set as LOCK_SCREEN '),
          ),
          ListTile(
            onTap: ()async{
              Navigator.pop(context);
              int Location = WallpaperManager.BOTH_SCREEN;
              var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
              await WallpaperManager.setWallpaperFromFile(file.path ,Location );

            },
            title: Text('set as BOTH_SCREEN'),
          )
        ],
      ),
    ),
  );
});
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: ElevatedButton(onPressed: (){
        saveimage();


      },
      child: loading?CircularProgressIndicator():Text('Set as Wallpaper'),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imageurl),
            fit: BoxFit.fill
          ),
        ),
      ),
    );
  }
}
