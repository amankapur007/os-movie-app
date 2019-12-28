class MovieDetailModel{
  String title;
  String imageUrl;

  MovieDetailModel.fromJSON(data){
    title=data['Ttile'];
    imageUrl=data['Poster'];
  }
}