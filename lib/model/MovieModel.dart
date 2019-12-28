class Movie{
  String id;
  String imageUrl;
  String rating;
  String title;
  int rank;
  String description;
  List<dynamic> subText;

  Movie.fromJSON(data){
    id=data['id'];
    imageUrl=data['image'];
    rating=data['rating'];
    title=data['title'];
    rank=data['rank'];
    description=data['description'];
    subText=data['subText'];
  }
}