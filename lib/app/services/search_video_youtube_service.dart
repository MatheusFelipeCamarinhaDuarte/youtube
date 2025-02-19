import 'dart:convert';

import 'package:http/http.dart';
import 'package:youtube/app/key/api.dart';
import 'package:youtube/app/model/video.dart';

abstract class SearchVideo {
  Future<List<Video>> getVideo(String search);
}

class SearchForVideo implements SearchVideo{
  @override
  Future<List<Video>> getVideo(String search) async {
    List<Video> videoList= <Video>[];
    Response response = await get(Uri.parse("${urlBase}search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&key=$youtubeKey"
        "&channelId=$channelKey"
        "&q=$search"
    ));
    print(response.statusCode);
    if (response.statusCode == 200){

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      // print("resultado: ${jsonData["items"][0]['snippet']['title'].toString()}");

      /* for (dynamic video in jsonData['items']){
        print(video.toString());
      }*/
      //print(videoList);

      videoList = jsonData['items'].map<Video>((dynamic videoMap){
        return Video.fromMap(videoMap as Map<String,dynamic>);
      }).toList();
    } else {
      print(response.body);
      print(response.statusCode);
    }
    return videoList;

  }

}