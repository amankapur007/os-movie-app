import 'package:flutter/material.dart';
import 'package:os_movie/model/MovieDetailModel.dart';
import 'package:os_movie/model/MovieModel.dart';
import 'package:os_movie/provider/MovieApi.dart';

class MyMovieWidget extends StatefulWidget {
  @override
  _MyMovieWidgetState createState() => _MyMovieWidgetState();
}

class _MyMovieWidgetState extends State<MyMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: Column(
        children: [
          TrendingMovie(),
          SizedBox(
            height: 20,
          ),
          Top10Movie()
        ],
      ),
    );
  }
}

class TrendingMovie extends StatefulWidget {
  MovieApi _movieApi = MovieApi();
  @override
  _TrendingMovieState createState() => _TrendingMovieState();
}

class _TrendingMovieState extends State<TrendingMovie> {
  List<Movie> trendingMovies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTrendingMovies();
  }

  _getTrendingMovies() async {
    var movies = await widget._movieApi.getTrending();
    setState(() {
      this.trendingMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Trending',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: width * 0.50,
          child: ListView.builder(
            itemCount: this.trendingMovies.length,
            itemBuilder: (BuildContext context, int index) {
              if(index<=20) {
                return MyCardWidget(movie: this.trendingMovies[index]);
              }
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}

class Top10Movie extends StatefulWidget {
  final MovieApi _movieApi = MovieApi();

  @override
  _Top10MovieState createState() => _Top10MovieState();
}

class _Top10MovieState extends State<Top10Movie> {
  List<Movie> movies = [];
  MovieDetailModel movie;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  _fetchMovies() async {
    final movies = await widget._movieApi.getTop10Movie();
    var f = await Future.wait(movies.map((movie) async {
      final movieData = await widget._movieApi.getMovieById(movie.id);
      movie.imageUrl = movieData.imageUrl;
      return movie;
    }));
    setState(() {
      this.movies = f;
    });
  }

  _movieById(String id) async {
    final MovieDetailModel movie = await widget._movieApi.getMovieById(id);
    return movie;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Top 10 Movies',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: width * 0.50,
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return MyCardWidget(movie: movies[index]);
            },
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}

class MyCardWidget extends StatefulWidget {
  Movie movie;
  @override
  _MyCardWidgetState createState() => _MyCardWidgetState();

  MyCardWidget({this.movie});
}

class _MyCardWidgetState extends State<MyCardWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              widget.movie.imageUrl,
              width: width * 0.35,
              height: width * 0.50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: width * 0.35,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
            child: Text(widget.movie.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 10.0)),
          ),
        )
      ],
    );
  }
}
