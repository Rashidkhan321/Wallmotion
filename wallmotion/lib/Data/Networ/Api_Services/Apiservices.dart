
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../../Utils/ToastMessage.dart';
import '../Api_Modal/PhotoModal.dart';




class photodata extends ChangeNotifier{// Home Screen

  Future<photomodal> getdata() async{
    try{
      String url ='https://pixabay.'
          'com/api/?key=45921971-b868e54f221b5ddee3971e46a&q=Background,4K Wallpaper&image_type=all&per_page=200';

      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body.toString());
      if(response.statusCode==200){

        return photomodal.fromJson(data);
      }
      else{
        throw Exception('error');
      }

    }
    on SocketException{
      throw   Utils.toastmessage('No Internet connection');



    }
    on TimeoutException{
      throw  Utils.toastmessage('Chec Internet Connection and Try Again');


    }

    notifyListeners();
  }
  Future<photomodal> serachdata(String query) async{// Serach Screen


    try{
      String url ='https://pixabay.'
          'com/api/?key=45921971-b868e54f221b5ddee3971e46a&q=$query&image_type=all&per_page=200';

      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body.toString());
      if(response.statusCode==200){

        return photomodal.fromJson(data);
      }
      else{
        throw Exception('error');
      }
    }
    on SocketException{
      throw   Utils.toastmessage('No Internet connection');



    }
    on TimeoutException{
      throw  Utils.toastmessage('Chec Internet Connection and Try Again');


    }

  }
}





