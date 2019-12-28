import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:os_movie/model/MovieDetailModel.dart';
import 'package:os_movie/model/MovieModel.dart';

class MovieApi{
  int id=null;
  final String apiKey = '&apikey=3aafe9c';
  final String top10Url = 'http://10.0.2.2:8080/top10';
   //'http://express2-express.apps.ca-central-1.starter.openshift-online.com/top10';

  final String movieByIdUrl = //'http://10.0.2.2:8080/top10';
        'http://omdbapi.com/?i=';
      //'http://express2-express.apps.ca-central-1.starter.openshift-online.com/movie?id=';

  final String trendingUrl = 'http://10.0.2.2:8080/trending';
        //'http://express2-express.apps.ca-central-1.starter.openshift-online.com/movie?id=';


    Future<List<Movie>> getTop10Movie() async{
       var res = await http.get('${top10Url}');
         final List<dynamic> parsedData = convert.json.decode(res.body);
         return parsedData.map((movie){
            return Movie.fromJSON(movie);
         }).toList();
    }

  Future<MovieDetailModel> getMovieById(String id) async{
      var url = movieByIdUrl+id+apiKey;
    var res = await http.get('${url}');
    final Map<String,dynamic> parsedData = convert.json.decode(res.body);
    return MovieDetailModel.fromJSON(parsedData);
    //print(Movie.fromJSON(parsedData).imageUrl);
  }

  Future<List<Movie>> getTrending() async{
    var res = await http.get('${trendingUrl}');
    final List<dynamic> parsedData = convert.json.decode(res.body);
    return parsedData.map((movie){
      return Movie.fromJSON(movie);
    }).toList();
  }
}