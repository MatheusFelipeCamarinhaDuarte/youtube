import 'dart:convert';

class Video{
  String image;
  String url;
  String title;
  String channel;
  String description;

  Video({
    required this.image,
    required this.url,
    required this.title,
    required this.channel,
    required this.description,
  });

  factory Video.fromMap(Map<String,dynamic> map){
    Map<String,dynamic> snippet = map['snippet'];
    return Video(
        image: snippet['thumbnails']['high']['url'] as String,
        url: map['id']['videoId'] as String,
        title: snippet['title'] as String,
        channel: snippet['channelTitle'] as String,
        description: snippet['description'] as String,
    );
  }

  factory Video.fromJson(String source) => Video.fromMap(jsonDecode(source) as Map<String, dynamic>);

  Map<String,dynamic> toMap(){
    return<String,dynamic>{
      'image':image,
      'url':url,
      'title':title,
      'description':description,
      'channel':channel,
    };
  }

  String toJson() => jsonEncode(toMap());

}