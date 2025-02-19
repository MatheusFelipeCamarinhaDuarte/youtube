import 'package:youtube/app/model/video.dart';
import 'package:youtube/app/services/search_video_youtube_service.dart';

class InitialViewmodel {
  List<Video> _videosList = <Video>[];

  Future<List<Video>> getVideoSearched(String query) async {
    final SearchForVideo service =SearchForVideo();
   _videosList =await service.getVideo(query);
   return _videosList;
  }

  List<Video> get videosList => _videosList;

}